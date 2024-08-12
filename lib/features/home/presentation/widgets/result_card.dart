import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/design/app_colors.dart';
import 'package:problem_perception_landing/features/auth/bloc/auth_bloc.dart';
import 'package:problem_perception_landing/features/results/models/result_model.dart';

import '../../../results/bloc/results_bloc.dart';
import 'results_heading.dart';

class ResultCard extends StatelessWidget {
  final ResultModel resultModel;
  const ResultCard({super.key, required this.resultModel});

  @override
  Widget build(BuildContext context) {
    // Determine the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive design adjustments
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1000;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
          color: resultModel.environmentalScore != null &&
                  resultModel.environmentalScore! > 85
              ? Colors.green[50]
              : null,
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildCardContent(context, isMobile: isMobile),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildCardContent(context, isMobile: isMobile),
              ),
      ),
    );
  }

  List<Widget> _buildCardContent(BuildContext context,
      {required bool isMobile}) {
    return [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pain Point and Category Row
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: isMobile ? double.infinity : 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ResultsHeading(
                      title: 'Pain Point', icon: Icon(Icons.help_outline)),
                  const SizedBox(height: 8.0),
                  Text(
                    resultModel.painPoint,
                    style: const TextStyle(fontSize: 16.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            // Suggested Solution
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: isMobile ? double.infinity : 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ResultsHeading(
                      title: 'Suggested Solution',
                      icon: Icon(Icons.help_outline)),
                  const SizedBox(height: 8.0),
                  Text(
                    resultModel.suggestedSolution ?? 'No solution found',
                    style: const TextStyle(fontSize: 16.0),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isMobile) const SizedBox(height: 12.0),
          ],
        ),
      ),
      if (!isMobile) const SizedBox(width: 16.0),
      Column(
        mainAxisAlignment:
            isMobile ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCompactScoreBox(
                label: 'Score',
                value: resultModel.score.toString(),
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8.0),
              _buildCompactScoreBox(
                label: 'Env',
                value: resultModel.environmentalScore?.toString() ?? 'N/A',
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<ResultsBloc>().add(
                        SaveToFavorites(
                          uid: state.user?.uid ??
                              FirebaseAuth.instance.currentUser!.uid,
                          result: resultModel,
                        ),
                      );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: BlocBuilder<ResultsBloc, ResultsState>(
                  builder: (resultsContext, resultsState) {
                    return resultModel.saved == true
                        ? const Icon(
                            Icons.done,
                            color: AppColors.textColor,
                          )
                        : const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.bookmark_outline),
                              SizedBox(width: 6),
                              Text('Save'),
                            ],
                          );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          if (resultModel.environmentalScore != null &&
              resultModel.environmentalScore! >= 85 &&
              resultModel.score >= 85)
            SizedBox(
                height: 50, child: Image.asset('assets/images/ikigai3.png')),
        ],
      ),
    ];
  }

  Widget _buildCompactScoreBox({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10.0,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
