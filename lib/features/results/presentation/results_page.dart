import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/core/widgets/web_body_template.dart';
import 'package:problem_perception_landing/features/home/presentation/widgets/result_card.dart';
import 'package:problem_perception_landing/features/home/presentation/widgets/results_heading.dart';

import '../bloc/results_bloc.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebBodyTemplate(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              context.read<ResultsBloc>().add(const NewSearchEvent());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'New Search',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
      // const SizedBox(height: 32),
      // const Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     ResultsHeading(title: 'Pain Point', icon: Icon(Icons.help_outline)),
      //     ResultsHeading(title: 'Painkiller', icon: Icon(Icons.help_outline)),
      //     ResultsHeading(title: 'Score', icon: Icon(Icons.help_outline)),
      //     ResultsHeading(
      //         title: 'Environmental Impact', icon: Icon(Icons.help_outline)),
      //     SizedBox(),
      //   ],
      // ),
      const SizedBox(height: 24),
      // Show a list of ResultCard widgets from the results found in results state, take the data from the bloc
      BlocBuilder<ResultsBloc, ResultsState>(
        builder: (context, state) {
          if (state.status == ResultsStatus.success) {
            return Column(
              children: state.results
                  .map((result) => ResultCard(
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
