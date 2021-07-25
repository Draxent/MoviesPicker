import 'dart:async';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_picker_client/data/repositories/movies_repository_impl.dart';
import 'package:movies_picker_client/data/models/data_error.dart';
import 'package:movies_picker_client/data/models/language.dart';
import 'package:movies_picker_client/data/models/location.dart';
import 'package:movies_picker_client/shared/shared.dart';

import '../test_utils.mocks.dart';

void main() {
  group('Get movie details.', () {
    test('Should get all the movie details when API response is correct',
        () async {
      final repository = _buildRepository(SharedConsts.responseOk);
      final movie = await repository.getMovieDetails(movieId);
      expect(movieId, movie.id);
      expect(Language.hindi, movie.language);
      expect(Location.chennai, movie.location);
      expect(true, movie.plot.startsWith('This is the tale of Harry Potter'));
      expect(2, movie.soundEffects.length);
      expect('RX6', movie.soundEffects[0]);
      expect('SDDS', movie.soundEffects[1]);
      expect(3, movie.stills.length);
      expect(true, movie.stills[0].endsWith('i3aD05u.png'));
      expect(true, movie.stills[1].endsWith('ABinULO.gif'));
      expect(true, movie.stills[2].endsWith('Wflfyct.gif'));
      expect("Harry Potter and the Sorcerer's Stone", movie.title);
      expect('tt0241527', movie.imdbID);
      expect(false, movie.isComingSoon);
      expect(7.6, movie.imdbRating);
    });

    test('Should get error when API response fails', () async {
      final repository =
          _buildRepository(SharedConsts.responseInternalServerError);
      expect(() async => await repository.getMovieDetails(movieId),
          throwsA(isA<DataError>()));
    });
  });
}

MoviesRepositoryImpl _buildRepository(int responseStatusCode) {
  final api = MockMoviesApi();
  when(api.getMovieDetails(movieId)).thenAnswer((_) =>
      Future.value(Response(rawJsonMovieDetailsResponse, responseStatusCode)));
  return MoviesRepositoryImpl(api);
}

//////////// DATA ////////////
const movieId = 6;
const rawJsonMovieDetailsResponse =
    '''{"id":$movieId,"language":"HINDI","location":"CHENNAI","plot":"This is the tale of Harry Potter, an ordinary 11-year-old boy serving as a sort of slave for his aunt and uncle who learns that he is actually a wizard and has been invited to attend the Hogwarts School for Witchcraft and Wizardry. Harry is snatched away from his mundane existence by Hagrid, the grounds keeper for Hogwarts, and quickly thrown into a world completely foreign to both him and the viewer. Famous for an incident that happened at his birth, Harry makes friends easily at his new school. He soon finds, however, that the wizarding world is far more dangerous for him than he would have imagined, and he quickly learns that not all wizards are ones to be trusted.","poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BNjQ3NWNlNmQtMTE5ZS00MDdmLTlkZjUtZTBlM2UxMGFiMTU3XkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_SX300.jpg","soundEffects":["RX6","SDDS"],"stills":["https://i.imgur.com/i3aD05u.png","https://i.imgur.com/ABinULO.gif","https://i.imgur.com/Wflfyct.gif"],"title":"Harry Potter and the Sorcerer's Stone","imdbID":"tt0241527","imdbRating":7.6,"listingType":"NOW_SHOWING"}''';
