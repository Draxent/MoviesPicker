import 'package:http/http.dart' as http;

import '../../shared/shared.dart';

import './movies_api.dart';

class MoviesApiImpl implements MoviesApi {
  MoviesApiImpl._();

  static final instance = MoviesApiImpl._();

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
