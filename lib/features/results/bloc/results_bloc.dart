import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/features/results/models/result_model.dart';
import 'package:problem_perception_landing/features/results/repository/results_repository.dart';
part 'results_event.dart';
part 'results_state.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  final ResultsRepository _resultsRepository;
  ResultsBloc(this._resultsRepository)
      : super(const ResultsState(ResultsStatus.initial, [], '')) {
    on<ResultsRequested>(_onResultsRequested);
    on<SaveToFavorites>(_onSaveToFavorites);
    on<NewSearchEvent>(_onNewSearchEvent);
  }
  _onResultsRequested(
      ResultsRequested event, Emitter<ResultsState> emit) async {
    emit(state.copyWith(status: ResultsStatus.loading));
    try {
      final results = await _resultsRepository.createDocumentAndGetResponse(
          {'business_idea': event.businessIdea}, event.uid);
      emit(state.copyWith(status: ResultsStatus.success, results: results));
    } catch (e) {
      emit(state.copyWith(
          status: ResultsStatus.failure, errorMessage: e.toString()));
    }
  }

  _onSaveToFavorites(SaveToFavorites event, Emitter<ResultsState> emit) async {
    emit(state.copyWith(status: ResultsStatus.loading));
    try {
      final updatedResults = state.results.map((result) {
        if (result.uid == event.result.uid) {
          return result.copyWith(saved: true);
        }
        return result;
      }).toList();
      emit(state.copyWith(results: updatedResults));
      await _resultsRepository.saveResultToFavorites(
          event.uid, event.result.copyWith(saved: true));
      emit(state.copyWith(status: ResultsStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: ResultsStatus.failure, errorMessage: e.toString()));
    }
  }

  _onNewSearchEvent(NewSearchEvent event, Emitter<ResultsState> emit) {
    emit(const ResultsState(ResultsStatus.initial, [], ''));
  }
}
