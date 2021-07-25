import 'package:flutter/material.dart';

import './language.dart';
import './location.dart';

@immutable
class MovieDetail {
  const MovieDetail({
    required this.id,
    required this.language,
    required this.location,
    required this.plot,
    required this.poster,
    required this.title,
    required this.imdbID,
    required this.imdbRating,
    required this.soundEffects,
    required this.stills,
    required this.isComingSoon,
  });

  factory MovieDetail.fromResponseData(Map<String, dynamic> data) =>
      MovieDetail(
        id: data[colId],
        language: LanguageParser.parse(data[colLanguage]),
        location: LocationParser.parse(data[colLocation]),
        plot: data[colPlot],
        poster: data[colPoster],
        title: data[colTitle],
        imdbID: data[colImdbID],
        imdbRating: data[colImdbRating],
        soundEffects: (data[colSoundEffects] as List<dynamic>)
            .map((x) => x as String)
            .toList(growable: false),
        stills: (data[colStills] as List<dynamic>)
            .map((x) => x as String)
            .toList(growable: false),
        isComingSoon: data[colListingType] == 'UP_COMING',
      );

  static const strLanguage = 'Language';
  static const strLocation = 'Location';
  static const strPlot = 'Plot';
  static const strPoster = 'Poster';
  static const strTitle = 'Title';
  static const strImdbID = 'IMDb ID';
  static const strImdbRating = 'IMDb Rating';
  static const strSoundEffects = 'Sound Effects';
  static const strStills = 'Stills';

  static const colId = 'id';
  static const colLanguage = 'language';
  static const colLocation = 'location';
  static const colPlot = 'plot';
  static const colPoster = 'poster';
  static const colTitle = 'title';
  static const colImdbID = 'imdbID';
  static const colImdbRating = 'imdbRating';
  static const colSoundEffects = 'soundEffects';
  static const colStills = 'stills';
  static const colListingType = 'listingType';

  static const maxImdbRating = 10.0;

  final int id;
  final Language language;
  final Location location;
  final String plot;
  final String poster;
  final String title;
  final String imdbID;
  final double imdbRating;
  final List<String> soundEffects;
  final List<String> stills;
  final bool isComingSoon;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetail &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '''{ 
    $colId: $id, $colLanguage: $language, $colLocation: $location, $colPlot: $plot, $colPoster: $poster,
    $colTitle: $title, $colImdbID: $imdbID, $colImdbRating: $imdbRating, $colSoundEffects: $soundEffects,
    $colStills: $stills, $colListingType: $isComingSoon,
    }''';
}
