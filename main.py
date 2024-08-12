import os
from dotenv import load_dotenv
from firebase_functions import https_fn, options
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from firebase_admin import initialize_app, firestore
import google.generativeai as genai
import logging
import typing_extensions as typing


# Initialize Firebase app
app = initialize_app()

# Load environment variables
load_dotenv()

# Set up API keys
GEMINI_API_KEY = os.getenv('GEMINI_API_KEY')
YOUTUBE_API_KEY = os.getenv('YOUTUBE_API_KEY')

# Constants for YouTube API
YOUTUBE_API_SERVICE_NAME = 'youtube'
YOUTUBE_API_VERSION = 'v3'

# Configure logging
logging.basicConfig(level=logging.INFO)

def get_top_5_videos(query):
    """Fetch the top YouTube video for a given query."""
    try:
        youtube = build(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION, developerKey=YOUTUBE_API_KEY)
        
        search_response = youtube.search().list(
            q=query,
            part='id,snippet',
            maxResults=5
        ).execute()

        video_ids = [item['id']['videoId'] for item in search_response['items']]

        # video_id = search_response['items'][0]['id']['videoId']
        logging.info(f"Top video ID for query '{query}': {video_ids}")
        
        return video_ids
    except KeyError as e:
        logging.error(f"KeyError while accessing video ID: {e}")
        raise ValueError("No video found for the given query.")
    except Exception as e:
        logging.error(f"Error fetching top video: {e}")
        raise

def get_video_comments(video_id):
    """Fetch comments for a YouTube video."""
    comments = []
    try:
        youtube = build(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION, developerKey=YOUTUBE_API_KEY)
        results = youtube.commentThreads().list(
            part="snippet",
            videoId=video_id,
            textFormat="plainText",
            maxResults=100,
            order='relevance'
        ).execute()

        for item in results.get("items", []):
            comment = item["snippet"]["topLevelComment"]["snippet"]
            comments.append({
                'text': comment['textDisplay'],
                'likeCount': comment['likeCount'],
                'totalReplyCount': item['snippet']['totalReplyCount'],
            })
        
        logging.info(f"Fetched {len(comments)} comments for video ID {video_id}")
        return comments if comments else None
    except HttpError as e:
        if e.resp.status == 403:
            logging.warning(f"403 Forbidden error for video ID {video_id}. Comments might be disabled.")
        else:
            logging.error(f"HTTP error occurred: {e}")
    except Exception as e:
        logging.error(f"Error fetching video comments: {e}")
        return None

class PainPoint(typing.TypedDict):
  uid: str
  pain_point: str
  score: int
  sentiment: int
  environmental_score: int
  predicted_impact: str
  suggested_solution: str



def get_pain_point_from_ai(comments, biz_idea):
    """Analyze comments using AI to find customer pain points."""
    try:
        genai.configure(api_key=GEMINI_API_KEY)
        model = genai.GenerativeModel('gemini-1.5-flash', generation_config={"response_mime_type": "application/json", "response_schema": list[PainPoint]})
        prompt = (
            f"I have a business idea, which is: {biz_idea}. I want to uncover customer pain points and also suggest potential solutions for each pain point. The pain points should be ones that I as an entrepreneur can solve. They should not include complaints about the video or its quality or the author of the video. "
            f"I am going to send you a list of YouTube comments. I want you to analyze them and find any comments that could be seen as customer pain points. "
            f"Return as many pain points as you can find from the comments, each with a score out of 100. Higher scores should be given to pain points that can be better solved by business opportunities. "
            f"Also, comments with higher like counts and reply counts should score higher. "
            f"For each identified pain point, I would also like you to conduct a sentiment analysis and provide a sentiment score. "
            f"For each pain point, generate a potential solution that fits the context of my business idea. The YouTube comments are: {comments}. "
            f"For each solution, give an environmental score out of 100, based on how beneficial it would be for the environment. "
            f"The response should include the pain point, its score, sentiment analysis, predicted impact if left unresolved, and a context-aware solution. "
            f"The uid should be a unique randomly generated 20 character mix of uppercase and lowercase letters, numbers."
        )
        response = model.generate_content(prompt)
        
        return response.text
    except Exception as e:
        logging.error(f"Error in AI processing: {e}")
        raise

@https_fn.on_call(
    cors=options.CorsOptions(
        cors_origins="*",
        cors_methods=["POST", "OPTIONS"]
    )
)
def get_pain_points(req: https_fn.CallableRequest):
    """Cloud function to get pain points from YouTube comments."""
    if not req.auth:
        logging.warning("Unauthorized access attempt.")
        return {"error": "Unauthorized User Trying To Access"}, 403

    data = req.data

    if data is None:
        logging.warning("No business idea provided in request.")
        return {"error": "Business idea is required"}, 400
    
    business_idea = data.get('business_idea')

    try:
        video_ids = get_top_5_videos(business_idea)
        comments_list = []
        for video in video_ids:
            comments_list.append(get_video_comments(video))
        pain_points = get_pain_point_from_ai(comments_list, business_idea)
        
        return pain_points
    except ValueError as ve:
        logging.error(f"Value error: {ve}")
        return {"error": str(ve)}, 400
    except Exception as e:
        logging.error(f"Exception occurred: {e}")
        return {"error": str(e)}, 500
