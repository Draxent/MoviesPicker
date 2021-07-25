import '../models/language.dart';
import '../models/location.dart';
import '../models/movie_details.dart';
import '../models/movie_poster.dart';

abstract class MoviesRepository {
  Future<List<MoviePoster>> getMovies({
    String? title,
    Language? language,
    Location? location,
  });

  Future<MovieDetails> getMovieDetails(int movieId);
}
