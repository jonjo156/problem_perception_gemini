part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {
  final String uid;
  const GetProfileEvent(this.uid);

  @override
  List<Object> get props => [uid];
}
