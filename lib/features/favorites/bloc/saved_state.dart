part of 'saved_bloc.dart';

enum SavedStatus { initial, loading, success, failure }

class SavedState extends Equatable {
  final SavedStatus status;
  final List<ResultModel> favorites;
  final String errorMessage;

  const SavedState(
    this.status,
    this.favorites,
    this.errorMessage,
  );

  @override
  List<Object> get props => [status, favorites, errorMessage];

  SavedState copyWith({
    SavedStatus? status,
    List<ResultModel>? favorites,
    String? errorMessage,
  }) {
    return SavedState(
      status ?? this.status,
      favorites ?? this.favorites,
      errorMessage ?? this.errorMessage,
    );
  }
}
