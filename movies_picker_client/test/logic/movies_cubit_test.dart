import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_picker_client/logic/movies_cubit.dart';
import 'package:movies_picker_client/data/models/data_error.dart';

import '../test_utils.mocks.dart';

void main() {
  group('Movies Cubit.', () {
    test('Should be in loading state when cubit is not invoked', () async {
      final repository = MockMoviesRepository();
      final cubit = MoviesCubit(repository);
      expect(const MoviesLoading(), cubit.state);
    });

    test('Should emit list of movies when repository does not throw', () async {
      final repository = MockMoviesRepository();
      final movies = [MockMoviePoster(), MockMoviePoster(), MockMoviePoster()];
      when(repository.getMovies()).thenAnswer((_) => Future.value(movies));
      final cubit = MoviesCubit(repository);
      await cubit.getMovies();
      verify(repository.getMovies());
      expect(MoviesLoaded(movies), cubit.state);
    });

    test('Should emit error when repository throws exception', () async {
      final repository = MockMoviesRepository();
      const error = DataError('error');
      when(repository.getMovies()).thenThrow(error);
      final cubit = MoviesCubit(repository);
      await cubit.getMovies();
      verify(repository.getMovies());
      expect(const MoviesError(error), cubit.state);
    });
  });
}
