part of 'results_bloc.dart';

enum ResultsStatus { initial, loading, success, failure }

class ResultsState extends Equatable {
  final ResultsStatus status;
  final List<ResultModel> results;
  final String errorMessage;
  const ResultsState(
    this.status,
    this.results,
    this.errorMessage,
  );

  @override
  List<Object> get props => [status, results];

  ResultsState copyWith({
    ResultsStatus? status,
    List<ResultModel>? results,
    String? errorMessage,
  }) {
    return ResultsState(
      status ?? this.status,
      results ?? this.results,
      errorMessage ?? this.errorMessage,
    );
  }
}
