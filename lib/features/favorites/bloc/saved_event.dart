part of 'saved_bloc.dart';

abstract class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends SavedEvent {
  final String uid;
  const LoadFavorites({required this.uid});
}
