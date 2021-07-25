import 'package:mockito/annotations.dart';
import 'package:movies_picker_client/data/api/movies_api.dart';
import 'package:movies_picker_client/data/models/movie_details.dart';
import 'package:movies_picker_client/data/models/movie_poster.dart';
import 'package:movies_picker_client/data/repositories/movies_repository.dart';

@GenerateMocks([MoviesApi, MovieDetails, MoviePoster, MoviesRepository])
abstract class TestUtils {}
