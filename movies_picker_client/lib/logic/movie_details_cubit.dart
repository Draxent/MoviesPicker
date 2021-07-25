import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/data_error.dart';
import '../data/models/movie_details.dart';
import '../data/repositories/movies_repository.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(this._repository) : super(const MovieDetailsLoading());

  final MoviesRepository _repository;

  Future<void> getMovieDetails(int movieId) async {
    try {
      final movie = await _repository.getMovieDetails(movieId);
      emit(MovieDetailsLoaded(movie));
    } on DataError catch (e) {
      emit(MovieDetailsError(e));
    }
  }
}

@immutable
abstract class MovieDetailsState {
  const MovieDetailsState();
}

class MovieDetailsLoading extends MovieDetailsState {
  const MovieDetailsLoading();
}

class MovieDetailsLoaded extends MovieDetailsState {
  const MovieDetailsLoaded(this.movie);

  final MovieDetails movie;

  @override
  String toString() => movie.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieDetailsLoaded &&
          runtimeType == other.runtimeType &&
          movie == other.movie);

  @override
  int get hashCode => movie.hashCode;
}

class MovieDetailsError extends MovieDetailsState {
  const MovieDetailsError(this._error);

  final DataError _error;

  String getMessage() => _error.message;

  @override
  String toString() => _error.message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieDetailsError &&
          runtimeType == other.runtimeType &&
          _error == other._error);

  @override
  int get hashCode => _error.hashCode;
}
