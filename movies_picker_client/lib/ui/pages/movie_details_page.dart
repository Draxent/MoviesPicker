import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../data/models/language.dart';
import '../../data/models/location.dart';
import '../../data/models/movie_details.dart';
import '../../logic/movie_details_cubit.dart';

import '../../shared/shared.dart';
import '../widgets/poster_viewer.dart';

import './error_page.dart';

class MovieDetailsPage extends StatelessWidget {
  static const routeName = '/movie';

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as int;
    return MovieDetailsLoader(movieId);
  }
}

class MovieDetailsLoader extends StatefulWidget {
  const MovieDetailsLoader(this.movieId);

  final int movieId;

  @override
  _MovieDetailsLoaderState createState() => _MovieDetailsLoaderState();
}

class _MovieDetailsLoaderState extends State<MovieDetailsLoader> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieDetailsCubit>(context).getMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (ctx, state) {
          if (state is MovieDetailsLoading) {
            return SharedWidgets.circularProgressIndicator;
          } else if (state is MovieDetailsError) {
            return ErrorPage(state.getMessage(), MovieDetailsPage.routeName);
          } else {
            return _MovieDetailsPage((state as MovieDetailsLoaded).movie);
          }
        },
      );
}

class _MovieDetailsPage extends StatelessWidget {
  const _MovieDetailsPage(this.movie);

  final MovieDetails movie;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: SafeArea(
          child: Padding(
            padding: _Consts.pagePadding,
            child: SingleChildScrollView(
              child: _MovieDetailViewer(movie),
            ),
          ),
        ),
      );
}

class _MovieDetailViewer extends StatelessWidget {
  const _MovieDetailViewer(this.movie);

  final MovieDetails movie;

  @override
  Widget build(BuildContext context) {
    final textStyleLabel = Theme.of(context).textTheme.bodyText1!;
    final screenWidth = SharedFunctions.getPageSize(context).width;
    final useColumnForPoster = screenWidth <
        (SharedSizes.poster.width +
            _Consts.tableWidth +
            _Consts.pagePadding.horizontal);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: useColumnForPoster
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        _buildPosterAndTable(useColumnForPoster, textStyleLabel),
        SharedWidgets.vSpace,
        SelectableText(MovieDetails.strPlot, style: textStyleLabel),
        Container(
          color: _Consts.bgPlot,
          child: Padding(
            padding: _Consts.plotPadding,
            child: SelectableText(movie.plot),
          ),
        ),
      ],
    );
  }

  Widget _buildPosterAndTable(
      bool useColumnForPoster, TextStyle textStyleLabel) {
    if (useColumnForPoster) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPoster(),
          SharedWidgets.vSpace,
          _buildDetailTable(textStyleLabel),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPoster(),
          _buildDetailTable(textStyleLabel),
        ],
      );
    }
  }

  Widget _buildPoster() => Container(
        color: Colors.black,
        width: SharedSizes.poster.width,
        height: SharedSizes.poster.height,
        child: PosterViewer(movie.id, movie.poster, movie.isComingSoon),
      );

  Widget _buildDetailTable(TextStyle textStyleLabel) => Container(
        width: _Consts.tableWidth,
        child: _MovieTableDetailViewer(movie, textStyleLabel),
      );
}

class _MovieTableDetailViewer extends StatelessWidget {
  const _MovieTableDetailViewer(this.movie, this.textStyleLabel);

  final MovieDetails movie;
  final TextStyle textStyleLabel;

  @override
  Widget build(BuildContext context) => Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _buildTextRow(MovieDetails.strTitle, movie.title),
          _buildTextRow(MovieDetails.strImdbID, movie.imdbID),
          _buildRow(
            MovieDetails.strImdbRating,
            RatingStars(
              value: movie.imdbRating,
              starCount: MovieDetails.maxImdbRating.toInt(),
              maxValue: MovieDetails.maxImdbRating,
            ),
          ),
          _buildTextRow(MovieDetails.strLanguage, movie.language.display),
          _buildTextRow(MovieDetails.strLocation, movie.location.display),
          _buildTextRow(MovieDetails.strSoundEffects,
              movie.soundEffects.join(SharedSymbol.commaSpace)),
          _buildRow(
            MovieDetails.strStills,
            Container(
              width: SharedSizes.stills.width,
              height: SharedSizes.stills.height,
              color: Colors.black,
              child: ImageSlideshow(
                children: movie.stills
                    .map((x) => Image.network(x))
                    .toList(growable: false),
              ),
            ),
          ),
        ],
      );

  TableRow _buildTextRow(String label, String text) =>
      _buildRow(label, SelectableText(text));

  TableRow _buildRow(String label, Widget child) => TableRow(
        children: [
          _buildCell(SelectableText(label, style: textStyleLabel)),
          _buildCell(child),
        ],
      );

  Widget _buildCell(Widget child) => Padding(
        padding: _Consts.tableRowPadding,
        child: FittedBox(fit: BoxFit.scaleDown, child: child),
      );
}

abstract class _Consts {
  static const tableWidth = 600.0;
  static const pagePadding = EdgeInsets.all(20);
  static const tableRowPadding = EdgeInsets.all(10);
  static const plotPadding = EdgeInsets.all(10);
  static const bgPlot = Color.fromARGB(255, 220, 220, 220);
}
