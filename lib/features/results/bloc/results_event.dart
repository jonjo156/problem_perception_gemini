part of 'results_bloc.dart';

abstract class ResultsEvent extends Equatable {
  const ResultsEvent();

  @override
  List<Object> get props => [];
}

class ResultsRequested extends ResultsEvent {
  final String businessIdea;
  final String uid;
  const ResultsRequested({required this.businessIdea, required this.uid});
}

class SaveToFavorites extends ResultsEvent {
  final ResultModel result;
  final String uid;
  const SaveToFavorites({required this.result, required this.uid});
}

class NewSearchEvent extends ResultsEvent {
  const NewSearchEvent();
}
