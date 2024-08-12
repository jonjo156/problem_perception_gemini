import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/core/widgets/web_body_template.dart';
import 'package:problem_perception_landing/features/favorites/bloc/saved_bloc.dart';
import 'package:problem_perception_landing/features/favorites/presentation/widgets/saved_card.dart';
import 'package:problem_perception_landing/features/home/presentation/widgets/result_card.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<SavedBloc>()
        .add(LoadFavorites(uid: FirebaseAuth.instance.currentUser!.uid));
  }

  @override
  Widget build(BuildContext context) {
    return WebBodyTemplate(children: [
      Text(
        'Saved Pain Points',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      const SizedBox(height: 32),
      // Show a list of ResultCard widgets from the results found in results state, take the data from the bloc
      BlocBuilder<SavedBloc, SavedState>(
        builder: (context, state) {
          if (state.status == SavedStatus.success) {
            return Column(
              children: state.favorites
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
