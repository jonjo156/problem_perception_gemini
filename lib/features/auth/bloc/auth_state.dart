part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  unknown,
  authenticated,
  authenticatedWithProfile,
  unauthenticated,
  failure
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;
  const AuthState(
    this.status,
    this.user,
    this.errorMessage,
  );

  @override
  List<Object?> get props => [status, user, errorMessage];

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return AuthState(
      status ?? this.status,
      user ?? this.user,
      errorMessage ?? this.errorMessage,
    );
  }
}
