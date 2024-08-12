part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends AuthEvent {
  final String email;
  final String password;
  const UserLoginEvent({required this.email, required this.password});
}

class UserSignUpWithGoogleEvent extends AuthEvent {
  const UserSignUpWithGoogleEvent();
}

class UserSignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  const UserSignUpWithEmailEvent({required this.email, required this.password});
}

class UserSignOutEvent extends AuthEvent {
  const UserSignOutEvent();
}

class AuthStateChangedEvent extends AuthEvent {
  final User? user;
  const AuthStateChangedEvent(this.user);
}

class ProfileCreatedEvent extends AuthEvent {
  final UserModel user;
  const ProfileCreatedEvent(this.user);
}
