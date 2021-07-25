import 'package:http/http.dart' as http;

import '../models/language.dart';
import '../models/location.dart';

abstract class MoviesApi {
  Future<http.Response> getMovies({
    String? title,
    Language? language,
    Location? location,
  });

  Future<http.Response> getMovieDetails(int movieId);
}
