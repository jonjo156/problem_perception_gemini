import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/core/widgets/web_body_template.dart';
import 'package:problem_perception_landing/features/home/presentation/widgets/result_card_mobile.dart';

import '../bloc/results_bloc.dart';

class ResultsPageMobile extends StatelessWidget {
  const ResultsPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return WebBodyTemplate(children: [
      const SizedBox(height: 24),
      BlocBuilder<ResultsBloc, ResultsState>(
        builder: (context, state) {
          if (state.status == ResultsStatus.success) {
            return Column(
              children: state.results
                  .map((result) => ResultCardMobile(
                        resultModel: result,
                      ))
                  .toList(),
            );
          }
          return const SizedBox();
        },
      ),
    ]);
  }
}
