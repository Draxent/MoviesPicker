import 'package:http/http.dart' as http;

abstract class MoviesApi {
  Future<http.Response> getMovieDetails(int movieId);
}
