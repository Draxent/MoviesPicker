import 'package:http/http.dart' as http;

import '../../shared/shared.dart';

import '../models/language.dart';
import '../models/location.dart';
import '../models/movie_details.dart';

import './movies_api.dart';

class MoviesApiImpl implements MoviesApi {
  MoviesApiImpl._();

  static final instance = MoviesApiImpl._();

  //FIXME: I am getting this error https://stackoverflow.com/questions/64458696/in-flutter-web-getting-xmlhttprequest-error-while-making-http-call
  // but the solution posted in stack overflow does not help.
  // The problem is not present in the mobile application.
  // So I am continuing with the table instead of the web.
  @override
  Future<http.Response> getMovies({
    String? title,
    Language? language,
    Location? location,
  }) =>
      http.get(
        Uri.http(
          SharedConsts.authorityURL,
          _Consts.url,
          {
            if (title != null) MovieDetails.colTitle: title,
            if (language != null) MovieDetails.colLanguage: language.display,
            if (location != null) MovieDetails.colLocation: location.display,
          },
        ),
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
