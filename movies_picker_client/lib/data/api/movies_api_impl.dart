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
      Future.value(http.Response(moviesResponse, SharedConsts.responseOk));

  //FIXME: I am getting this error https://stackoverflow.com/questions/64458696/in-flutter-web-getting-xmlhttprequest-error-while-making-http-call but the solution posted in stack overflow does not help
  Future<http.Response> getMoviesReal({
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
        headers: {
          'Access-Control-Allow-Headers': 'Access-Control-Allow-Origin, Accept',
          'Access-Control-Allow-Origin': '*',
          'Accept': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
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

const moviesResponse =
    '''[{"id":1,"poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMTcxODgwMDkxNV5BMl5BanBnXkFtZTYwMDk2MDg3._V1_SX300.jpg","listingType":"NOW_SHOWING"},{"id":2,"poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMjIyZGU4YzUtNDkzYi00ZDRhLTljYzctYTMxMDQ4M2E0Y2YxXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg","listingType":"NOW_SHOWING"},{"id":3,"poster":"https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_QL50_.jpg","listingType":"NOW_SHOWING"},{"id":4,"poster":"https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_QL50_SY1000_CR0,0,704,1000_AL_.jpg","listingType":"UP_COMING"},{"id":5,"poster":"https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_QL50_SY1000_CR0,0,675,1000_AL_.jpg","listingType":"NOW_SHOWING"},{"id":6,"poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BNjQ3NWNlNmQtMTE5ZS00MDdmLTlkZjUtZTBlM2UxMGFiMTU3XkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_SX300.jpg","listingType":"NOW_SHOWING"},{"id":7,"poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMTM0NTczMTUzOV5BMl5BanBnXkFtZTYwMzIxNTg3._V1_SX300.jpg","listingType":"UP_COMING"},{"id":8,"poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMTY4NTIwODg0N15BMl5BanBnXkFtZTcwOTc0MjEzMw@@._V1_SX300.jpg","listingType":"NOW_SHOWING"},{"id":9,"poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMTI1NDMyMjExOF5BMl5BanBnXkFtZTcwOTc4MjQzMQ@@._V1_SX300.jpg","listingType":"NOW_SHOWING"},{"id":10,"poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ2OTE1Mjk0N15BMl5BanBnXkFtZTcwODE3MDAwNA@@._V1_SX300.jpg","listingType":"NOW_SHOWING"}]''';
