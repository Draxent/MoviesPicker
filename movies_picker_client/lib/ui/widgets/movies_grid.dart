import 'package:flutter/material.dart';

import '../../data/models/movie_poster.dart';

import '../../shared/shared.dart';

import '../pages/movie_details_page.dart';
import './poster_viewer.dart';

class MoviesGridController extends StatelessWidget {
  const MoviesGridController(this.movies);

  final List<MoviePoster> movies;

  @override
  Widget build(BuildContext context) => _MoviesGridViewer(movies);
}

class _MoviesGridViewer extends StatelessWidget {
  const _MoviesGridViewer(this.movies);

  final List<MoviePoster> movies;

  @override
  Widget build(BuildContext context) {
    final screenWidth = SharedFunctions.getPageSize(context).width;
    final numXRow = screenWidth ~/ SharedSizes.poster.width;
    return GridView.builder(
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numXRow,
        crossAxisSpacing: _Consts.gridCrossAxisSpacing,
        mainAxisSpacing: _Consts.gridMainAxisSpacing,
        childAspectRatio: SharedSizes.posterRatio,
      ),
      itemBuilder: (BuildContext _, int index) => _MovieViewer(movies[index]),
    );
  }
}

class _MovieViewer extends StatelessWidget {
  const _MovieViewer(this.movie);

  final MoviePoster movie;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          MovieDetailsPage.routeName,
          arguments: movie,
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            color: Colors.black,
            child: PosterViewer(movie.id, movie.poster, movie.isComingSoon),
          ),
        ),
      );
}

abstract class _Consts {
  static const gridCrossAxisSpacing = 50.0;
  static const gridMainAxisSpacing = 30.0;
}
