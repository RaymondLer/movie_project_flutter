part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class LoadingState extends MovieState {}

class LoadedState extends MovieState {}

class FailedState extends MovieState {
  final String message;

  const FailedState({required this.message});

  @override
  List<Object> get props => [message];
}
