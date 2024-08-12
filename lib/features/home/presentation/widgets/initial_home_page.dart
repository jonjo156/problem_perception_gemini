import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:problem_perception_landing/features/auth/bloc/auth_bloc.dart';
import 'package:problem_perception_landing/features/home/presentation/widgets/how_it_works.dart';
import 'package:problem_perception_landing/features/results/bloc/results_bloc.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../../core/widgets/web_body_template.dart';

class InitialHomePage extends StatefulWidget {
  InitialHomePage({super.key});

  @override
  State<InitialHomePage> createState() => _InitialHomePageState();
}

class _InitialHomePageState extends State<InitialHomePage> {
  final TextEditingController _textController = TextEditingController();

  final stt.SpeechToText speech = stt.SpeechToText();
  String lastStatus = '';
  String lastError = '';
  String lastWords = '';
  bool micActive = false;

  void statusListener(String status) {
    debugPrint(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = status;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    debugPrint(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    debugPrint(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebBodyTemplate(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return const HowItWorks();
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'How It Works',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )),
          ],
        ),
        const SizedBox(height: 60),
        SvgPicture.asset('assets/images/svgs/robot.svg'),
        const SizedBox(height: 48),
        Text(
          'Find customer pain points in seconds',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: const Text(
            'Enter a problem you want to solve and we will scour the deepest holes of the internet to find the most common pain points that customers have with your idea.',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 60),
        Container(
          constraints: const BoxConstraints(maxHeight: 80, maxWidth: 600),
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor,
            borderRadius: BorderRadius.circular(36),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Row(
              children: [
                const Icon(Icons.search),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        hintText:
                            'Enter Your Business Idea E.g Grooming Service For Dogs',
                        border: InputBorder.none,
                        hintStyle: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          if (state.status != AuthStatus.unauthenticated) {
                            context.read<ResultsBloc>().add(ResultsRequested(
                                businessIdea: _textController.text,
                                uid: state.user?.uid ??
                                    FirebaseAuth.instance.currentUser!.uid));
                          } else {
                            debugPrint(
                                'User is null: state is ${state.status}');
                          }
                        },
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/svgs/sparkles_black.svg'),
                              const SizedBox(width: 8),
                              Text(
                                'Search',
                                //TODO: Get Nick to define a text for buttons
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ));
                  },
                ),
                const SizedBox(width: 12),
                InkWell(
                    onTap: () async {
                      bool available = await speech.initialize(
                          onStatus: statusListener, onError: errorListener);
                      if (available) {
                        speech.listen(onResult: resultListener);
                      } else {
                        print(
                            "The user has denied the use of speech recognition.");
                      }
                      // some time later...
                      Future.delayed(const Duration(seconds: 5), () {
                        speech.stop();
                        context.read<ResultsBloc>().add(ResultsRequested(
                            businessIdea: _textController.text,
                            uid: FirebaseAuth.instance.currentUser!.uid));
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: micActive ? Colors.green[400] : null,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.mic),
                        )))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
