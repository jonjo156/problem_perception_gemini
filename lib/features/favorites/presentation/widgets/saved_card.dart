import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/design/app_colors.dart';
import 'package:problem_perception_landing/features/auth/bloc/auth_bloc.dart';
import 'package:problem_perception_landing/features/results/models/result_model.dart';

import '../../../results/bloc/results_bloc.dart';

class SavedCard extends StatelessWidget {
  final ResultModel resultModel;
  const SavedCard({super.key, required this.resultModel});

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                resultModel.painPoint,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(width: 16.0),
            Flexible(
              flex: 1,
              child: Text(
                'Vitamin',
                style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(width: 16.0),
            Flexible(
              flex: 1,
              child: Container(
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
            ),
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
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: Text('Solve it!'),
                      )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
