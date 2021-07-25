import 'package:flutter/material.dart';

@immutable
class MoviePoster {
  const MoviePoster({
    required this.id,
    required this.poster,
    required this.isComingSoon,
  });

  factory MoviePoster.fromResponseData(Map<String, dynamic> data) =>
      MoviePoster(
        id: data[colId],
        poster: data[colPoster],
        isComingSoon: data[colListingType] == 'UP_COMING',
      );

  static const colId = 'id';
  static const colPoster = 'poster';
  static const colListingType = 'listingType';

  final int id;
  final String poster;
  final bool isComingSoon;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviePoster &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '''{ 
    $colId: $id, $colPoster: $poster, $colListingType: $isComingSoon
    }''';
}
