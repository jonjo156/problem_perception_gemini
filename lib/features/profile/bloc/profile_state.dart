part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserModel user;
  final String errorMessage;

  const ProfileState(
    this.status,
    this.user,
    this.errorMessage,
  );

  @override
  //TODO: check consequences of null assertion here
  List<Object> get props => [status, user, errorMessage];

  ProfileState copyWith({
    ProfileStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return ProfileState(
      status ?? this.status,
      user ?? this.user,
      errorMessage ?? this.errorMessage,
    );
  }
}
