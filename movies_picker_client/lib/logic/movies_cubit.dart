import 'package:collection/collection.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/data_error.dart';
import '../data/models/language.dart';
import '../data/models/location.dart';
import '../data/models/movie_poster.dart';
import '../data/repositories/movies_repository.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this._repository) : super(const MoviesLoading());

  final MoviesRepository _repository;

  Future<void> getMovies({
    String? title,
    Language? language,
    Location? location,
  }) async {
    try {
      final movies = await _repository.getMovies(
          title: title, language: language, location: location);
      emit(MoviesLoaded(movies));
    } on DataError catch (e) {
      emit(MoviesError(e));
    }
  }
}

@immutable
abstract class MoviesState {
  const MoviesState();
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
}

class MoviesLoaded extends MoviesState {
  const MoviesLoaded(this.movies);

  final List<MoviePoster> movies;

  @override
  String toString() => movies.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoviesLoaded &&
          runtimeType == other.runtimeType &&
          const ListEquality().equals(movies, other.movies));

  @override
  int get hashCode => movies.hashCode;
}

class MoviesError extends MoviesState {
  const MoviesError(this._error);

  final DataError _error;

  String getMessage() => _error.message;

  @override
  String toString() => _error.message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoviesError &&
          runtimeType == other.runtimeType &&
          _error == other._error);

  @override
  int get hashCode => _error.hashCode;
}
