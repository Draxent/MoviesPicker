import 'dart:convert';
import 'package:flutter/material.dart';

import '../../shared/shared.dart';

import '../api/movies_api.dart';
import '../api/movies_api_impl.dart';

import '../models/data_error.dart';
import '../models/movie_detail.dart';

import './movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRepositoryImpl(this._moviesApi);

  final MoviesApi _moviesApi;

  static final instance = MoviesRepositoryImpl(MoviesApiImpl.instance);

  @override
  Future<MovieDetail> getMovieDetails(int movieId) async {
    final response = await _moviesApi.getMovieDetails(movieId);
    if (response.statusCode != SharedConsts.responseOk) {
      throw _cannotGetMovieDetails(movieId);
    }
    try {
      final Map<String, dynamic> movieRaw = json.decode(response.body);
      return MovieDetail.fromResponseData(movieRaw);
    } catch (e, s) {
      logger.e('Error: $e, Stack: $s');
      throw _cannotGetMovieDetails(movieId);
    }
  }

  DataError _cannotGetMovieDetails(int movieId) =>
      DataError('cannot get the movie detail of movie $movieId');

  @visibleForTesting
  MoviesApi get api => _moviesApi;
}
