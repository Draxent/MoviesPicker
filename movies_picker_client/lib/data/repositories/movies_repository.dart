import '../models/movie_detail.dart';

abstract class MoviesRepository {
  Future<MovieDetail> getMovieDetails(int movieId);
}
