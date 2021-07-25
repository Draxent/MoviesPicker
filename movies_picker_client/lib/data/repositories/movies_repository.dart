import '../models/language.dart';
import '../models/location.dart';
import '../models/movie_detail.dart';
import '../models/movie_poster.dart';

abstract class MoviesRepository {
  Future<List<MoviePoster>> getMovies({
    String? title,
    Language? language,
    Location? location,
  });

  Future<MovieDetail> getMovieDetails(int movieId);
}
