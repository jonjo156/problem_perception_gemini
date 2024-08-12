import 'package:flutter/material.dart';
import 'package:problem_perception_landing/design/app_colors.dart';
import 'package:problem_perception_landing/features/results/models/result_model.dart';

import 'results_heading.dart';

class ResultCardMobile extends StatelessWidget {
  final ResultModel resultModel;
  const ResultCardMobile({super.key, required this.resultModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ResultsHeading(
                title: 'Pain Point', icon: Icon(Icons.help_outline)),
            const SizedBox(height: 8.0),
            Text(
              resultModel.painPoint,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 24.0),
            const ResultsHeading(
                title: 'Painkiller', icon: Icon(Icons.help_outline)),
            const SizedBox(height: 8.0),
            const Text(
              'Vitamin',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 24.0),
            const ResultsHeading(
                title: 'Score', icon: Icon(Icons.help_outline)),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                resultModel.score.toString(),
                style: const TextStyle(
                  fontSize: 18.0,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_outline),
                      SizedBox(width: 6),
                      Text('Save'),
                    ],
                  ),
                )),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
