import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/core/widgets/web_body_template.dart';
import 'package:problem_perception_landing/features/home/presentation/widgets/initial_home_page.dart';
import 'package:problem_perception_landing/features/results/bloc/results_bloc.dart';
import 'package:problem_perception_landing/features/results/presentation/results_page.dart';
import 'package:problem_perception_landing/features/results/presentation/results_page_mobile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultsBloc, ResultsState>(
      builder: (context, state) {
        if (state.status == ResultsStatus.initial) {
          return InitialHomePage();
        } else if (state.status == ResultsStatus.loading) {
          return const WebBodyTemplate(
            children: [Center(child: CircularProgressIndicator())],
          );
        } else if (state.status == ResultsStatus.success) {
          return MediaQuery.of(context).size.width > 600
              ? const ResultsPage()
              : const ResultsPageMobile();
        }
        return InitialHomePage();
      },
    );
  }
}
