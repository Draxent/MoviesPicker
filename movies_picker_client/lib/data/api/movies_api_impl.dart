import 'package:http/http.dart' as http;

import '../../shared/shared.dart';

import '../models/language.dart';
import '../models/location.dart';
import '../models/movie_details.dart';

import './movies_api.dart';

class MoviesApiImpl implements MoviesApi {
  MoviesApiImpl._();

  static final instance = MoviesApiImpl._();

  @override
  Future<http.Response> getMovies({
    String? title,
    Language? language,
    Location? location,
  }) =>
      http.get(
        Uri.http(SharedConsts.authorityURL, _Consts.url, {
          if (title != null) MovieDetails.colTitle: title,
          if (language != null) MovieDetails.colLanguage: language.display,
          if (location != null) MovieDetails.colLocation: location.display,
        }),
      );

  @override
  Future<http.Response> getMovieDetails(int movieId) => http.get(
        Uri.http(
          SharedConsts.authorityURL,
          '${_Consts.url}/$movieId',
        ),
      );
}

abstract class _Consts {
  static const url = '${SharedConsts.baseURL}/movies';
}
