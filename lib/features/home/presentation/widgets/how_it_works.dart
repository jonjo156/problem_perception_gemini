import 'package:flutter/material.dart';

class HowItWorks extends StatelessWidget {
  const HowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Welcome to the Pain Point App! Here\'s how it works:'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const SizedBox(height: 16),
              Text(
                '1. Search the Internet',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'The app searches the web for discussions, reviews, and feedback across various platforms where users express their pain points and concerns.',
              ),
              const SizedBox(height: 16),
              Text(
                '2. Sentiment Analysis',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'The app performs sentiment analysis on the collected data to determine the emotional tone of the feedback. It identifies whether the sentiment is positive, negative, or neutral.',
              ),
              const SizedBox(height: 16),
              Text(
                '3. Identify Pain Points',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'Based on the sentiment analysis, the app identifies recurring issues or concerns that users are expressing. These are the pain points that you can focus on resolving.',
              ),
              const SizedBox(height: 16),
              Text(
                '4. Insights and Reports',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'The app provides insights and reports on the most common pain points, helping you to understand what matters most to your users and how you can improve their experience.',
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Got it!'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
