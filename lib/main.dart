import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/core/router/router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:problem_perception_landing/design/theme.dart';
import 'package:problem_perception_landing/features/results/bloc/results_bloc.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/favorites/bloc/saved_bloc.dart';
import 'features/profile/bloc/profile_bloc.dart';
import 'service_locator.dart' as di;

void main() async {
  // ignore: prefer_const_constructors
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ResultsBloc>(
        create: (context) => di.sl<ResultsBloc>(),
      ),
      BlocProvider<AuthBloc>(
        create: (context) => di.sl<AuthBloc>(),
      ),
      BlocProvider<SavedBloc>(
        create: (context) => di.sl<SavedBloc>(),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) => di.sl<ProfileBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Problem Perception',
      theme: AppTheme.getTheme(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
