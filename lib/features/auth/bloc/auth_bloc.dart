import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/features/auth/models/user_model.dart';
import 'package:problem_perception_landing/features/profile/repository/profile_repository.dart';

import '../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  late final StreamSubscription<User?> _authStateSubscription;

  AuthBloc(this._authRepository, this._profileRepository)
      : super(
          const AuthState(AuthStatus.initial, null, null),
        ) {
    on<UserLoginEvent>(_onUserLogin);
    on<UserSignUpWithEmailEvent>(_onUserSignUpWithEmailAndPassword);
    on<UserSignUpWithGoogleEvent>(_onUserSignUpWithGoogle);
    on<UserSignOutEvent>(_onUserSignOutEvent);
    on<AuthStateChangedEvent>(_onAuthStateChangedEvent);
    on<ProfileCreatedEvent>(_onProfileCreatedEvent);
    _authStateSubscription = _authRepository.authStateChanges.listen((user) {
      add(AuthStateChangedEvent(user));
    });
  }

  _onUserLogin(UserLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final firebaseUser = await _authRepository.loginWithEmailAndPassword(
          event.email, event.password);
      final UserModel userModel =
          await _profileRepository.getUser(firebaseUser!.uid);
      if (userModel.firstName == null) {
        emit(state.copyWith(
            status: AuthStatus.authenticated, user: firebaseUser));
      } else {
        emit(state.copyWith(
            status: AuthStatus.authenticatedWithProfile, user: userModel));
      }
      emit(state.copyWith(
          status: AuthStatus.authenticatedWithProfile, user: firebaseUser!));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure, errorMessage: e.toString()));
    }
  }

  _onUserSignUpWithEmailAndPassword(
      UserSignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final firebaseUser = await _authRepository.signUpWithEmailAndPassword(
          event.email, event.password);

      emit(state.copyWith(
          status: AuthStatus.authenticated, user: firebaseUser!));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure, errorMessage: e.toString()));
    }
  }

  _onUserSignUpWithGoogle(
      UserSignUpWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final googleUser = await _authRepository.signUpWithGoogle();
      final UserModel userModel =
          await _profileRepository.getUser(googleUser!.uid);
      if (userModel.firstName == null) {
        emit(
            state.copyWith(status: AuthStatus.authenticated, user: googleUser));
      } else {
        emit(state.copyWith(
            status: AuthStatus.authenticatedWithProfile, user: userModel));
      }
      emit(state.copyWith(status: AuthStatus.authenticated, user: googleUser!));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure, errorMessage: e.toString()));
    }
  }

  _onUserSignOutEvent(UserSignOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      _authRepository.signOut();
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure, errorMessage: e.toString()));
    }
  }

  _onAuthStateChangedEvent(
      AuthStateChangedEvent event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(state.copyWith(status: AuthStatus.authenticated));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  _onProfileCreatedEvent(ProfileCreatedEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.loading, user: event.user));
    try {
      _authRepository.createProfile(event.user);
      emit(state.copyWith(status: AuthStatus.authenticatedWithProfile));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
