import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './data/repositories/movies_repository_impl.dart';
import './logic/movie_details_cubit.dart';
import './logic/movies_cubit.dart';
import './shared/shared.dart';
import './ui/pages/movie_detail_page.dart';
import './ui/pages/movies_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext ctx) =>
                MoviesCubit(MoviesRepositoryImpl.instance),
          ),
          BlocProvider(
            create: (BuildContext ctx) =>
                MovieDetailsCubit(MoviesRepositoryImpl.instance),
          ),
        ],
        child: _buildApp(context),
      );

  Widget _buildApp(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
      title: SharedConsts.appName,
      routes: {
        MoviesPage.routeName: (BuildContext _) => MoviesPage(),
        MovieDetailPage.routeName: (BuildContext _) => MovieDetailPage(),
      },
      theme: ThemeData(
        primaryColor: const Color(0xFF421c45),
        accentColor: Colors.orange,
        textTheme: theme.textTheme.copyWith(
          bodyText1: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: const TextStyle(
            fontSize: 20,
          ),
          button: const TextStyle(
            fontSize: 22,
          ),
        ),
        appBarTheme: theme.appBarTheme.copyWith(
          textTheme: const TextTheme(
            headline6: TextStyle(
              fontSize: 26,
              color: Colors.white,
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
