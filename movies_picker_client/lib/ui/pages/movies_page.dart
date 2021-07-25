import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/language.dart';
import '../../data/models/location.dart';
import '../../data/models/movie_poster.dart';
import '../../logic/movies_cubit.dart';
import '../../logic/search_criteria_provider.dart';
import '../../shared/shared.dart';

import '../widgets/movies_grid.dart';
import '../widgets/search_bar.dart';

import './error_page.dart';

class MoviesPage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchCriteriaProvider>();
    return MoviesLoader(
        UniqueKey(), provider.title, provider.language, provider.location);
  }
}

class MoviesLoader extends StatefulWidget {
  const MoviesLoader(Key key, this.title, this.language, this.location)
      : super(key: key);

  final String? title;
  final Language? language;
  final Location? location;

  @override
  _MoviesLoaderState createState() => _MoviesLoaderState();
}

class _MoviesLoaderState extends State<MoviesLoader> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesCubit>(context).getMovies(
      title: widget.title,
      language: widget.language,
      location: widget.location,
    );
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<MoviesCubit, MoviesState>(
        builder: (ctx, state) {
          if (state is MoviesLoading) {
            return SharedWidgets.circularProgressIndicator;
          } else if (state is MoviesError) {
            return ErrorPage(state.getMessage(), MoviesPage.routeName);
          } else {
            return _MoviesPage((state as MoviesLoaded).movies);
          }
        },
      );
}

class _MoviesPage extends StatelessWidget {
  const _MoviesPage(this.movies);

  final List<MoviePoster> movies;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Center(
            child: SearchBarController(),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: MoviesGridViewer(movies),
          ),
        ),
      );
}
