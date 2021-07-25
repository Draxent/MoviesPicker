import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_picker_client/logic/movie_details_cubit.dart';
import 'package:movies_picker_client/data/models/data_error.dart';

import '../test_utils.mocks.dart';

void main() {
  group('Movie Details Cubit.', () {
    test('Should be in loading state when cubit is not invoked', () async {
      final repository = MockMoviesRepository();
      final cubit = MovieDetailsCubit(repository);
      expect(const MovieDetailsLoading(), cubit.state);
    });

    test('Should emit movie details when repository does not throw', () async {
      final repository = MockMoviesRepository();
      final movie = MockMovieDetails();
      when(repository.getMovieDetails(movieId))
          .thenAnswer((_) => Future.value(movie));
      final cubit = MovieDetailsCubit(repository);
      await cubit.getMovieDetails(movieId);
      verify(repository.getMovieDetails(movieId));
      expect(MovieDetailsLoaded(movie), cubit.state);
    });

    test('Should emit error when repository throws exception', () async {
      final repository = MockMoviesRepository();
      const error = DataError('error');
      when(repository.getMovieDetails(movieId)).thenThrow(error);
      final cubit = MovieDetailsCubit(repository);
      await cubit.getMovieDetails(movieId);
      verify(repository.getMovieDetails(movieId));
      expect(const MovieDetailsError(error), cubit.state);
    });
  });
}

//////////// DATA ////////////
const movieId = 6;
