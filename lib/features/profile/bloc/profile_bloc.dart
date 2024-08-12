import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/models/user_model.dart';
import '../repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  ProfileBloc(this._profileRepository)
      : super(ProfileState(
            ProfileStatus.initial, UserModel(email: '', uid: ''), '')) {
    on<GetProfileEvent>(_onGetProfileEvent);
  }
  _onGetProfileEvent(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final userModel = await _profileRepository.getUser(event.uid);
      emit(state.copyWith(status: ProfileStatus.success, user: userModel));
    } catch (e) {
      emit(state.copyWith(
          status: ProfileStatus.failure, errorMessage: e.toString()));
    }
  }
}
