import 'package:movie_mate/features/detail_page/bloc/movie_detail_bloc.dart';
import 'package:movie_mate/features/detail_page/repository/movie_detail_repository.dart';
import 'package:movie_mate/features/home/bloc/coming_soon/coming_soon_movies_bloc.dart';
import 'package:movie_mate/features/home/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movie_mate/features/home/repository/movie_home_repository.dart';

import 'core/core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<IntroductionCubit>(
            create: (_) => IntroductionCubit(),
          ),
          BlocProvider(
            create: (_) => NowPlayingMoviesBloc(
              MovieHomeRepositoryImpl.create(),
            ),
          ),
          BlocProvider(
            create: (_) => ComingSoonMoviesBloc(
              MovieHomeRepositoryImpl.create(),
            ),
          ),
          BlocProvider(
            create: (_) => MovieDetailBloc(
              MovieDetailRepositoryImpl.create(),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Movie Mate',
          theme: AppTheme.darkTheme,
          navigatorKey: navigatorKey,
          initialRoute: RoutesName.initial,
          onGenerateRoute: RoutesHandler.onGenerateRoute,
          debugShowCheckedModeBanner: false,
        ));
  }
}
