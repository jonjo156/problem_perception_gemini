import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:problem_perception_landing/core/services/firestore_service.dart';
import 'package:problem_perception_landing/features/auth/repository/auth_repository.dart';
import 'package:problem_perception_landing/features/favorites/repository/saved_repository.dart';
import 'package:problem_perception_landing/features/profile/repository/profile_repository.dart';

import 'features/auth/bloc/auth_bloc.dart';
import 'features/favorites/bloc/saved_bloc.dart';
import 'features/profile/bloc/profile_bloc.dart';
import 'features/results/bloc/results_bloc.dart';
import 'features/results/repository/results_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  sl.registerLazySingleton<FirebaseFunctions>(() => FirebaseFunctions.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Services
  sl.registerLazySingleton<FirestoreService>(() => FirestoreService(sl()));

  // Repository
  sl.registerLazySingleton<ResultsRepository>(
      () => ResultsRepository(sl(), sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl(), sl()));
  sl.registerLazySingleton<SavedRepository>(() => SavedRepository(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepository(sl()));

  // Bloc
  sl.registerFactory<ResultsBloc>(() => ResultsBloc(sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerFactory<SavedBloc>(() => SavedBloc(sl()));
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl()));
}
