import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:problem_perception_landing/features/favorites/repository/saved_repository.dart';

import '../../results/models/result_model.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final SavedRepository _savedRepository;
  SavedBloc(this._savedRepository)
      : super(const SavedState(SavedStatus.initial, [], '')) {
    on<LoadFavorites>(_onLoadFavorites);
  }
  _onLoadFavorites(LoadFavorites event, Emitter<SavedState> emit) async {
    emit(state.copyWith(status: SavedStatus.loading));
    try {
      final favorites = await _savedRepository.loadFavorites(event.uid);
      emit(state.copyWith(status: SavedStatus.success, favorites: favorites));
    } catch (e) {
      emit(state.copyWith(
          status: SavedStatus.failure, errorMessage: e.toString()));
    }
  }
}
