import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/features/auth/bloc/auth_bloc.dart';
import 'package:problem_perception_landing/features/auth/presentation/widgets/loading_dialog.dart';
import 'package:problem_perception_landing/features/auth/presentation/widgets/profile_dialog.dart';

import 'widgets/auth_dialog.dart';

class AuthFlowWidget extends StatelessWidget {
  const AuthFlowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return ProfileDialog();
        } else if (state.status == AuthStatus.unauthenticated) {
          return AuthDialog();
        }
        return const LoadingDialog();
      },
    );
  }
}
