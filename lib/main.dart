import 'package:firebase_core/firebase_core.dart';
import 'features/auth/bloc/forgot_password/forgot_password_bloc.dart';
import 'features/auth/bloc/login/login_bloc.dart';
import 'features/auth/bloc/login_google/login_google_bloc.dart';
import 'features/auth/bloc/logout/logout_bloc.dart';
import 'features/auth/bloc/register/register_bloc.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/detail_page/bloc/movie_detail_bloc.dart';
import 'features/detail_page/repository/movie_detail_repository.dart';
import 'features/edit_profile/bloc/edit_user_bloc.dart';
import 'features/edit_profile/repository/edit_profile_repository.dart';
import 'features/home/bloc/coming_soon/coming_soon_movies_bloc.dart';
import 'features/home/bloc/now_playing/now_playing_movies_bloc.dart';
import 'features/home/repository/movie_home_repository.dart';
import 'features/profile/bloc/change_password/change_password_bloc.dart';
import 'features/profile/bloc/user/user_bloc.dart';
import 'features/profile/repository/profile_repository.dart';

import 'core/core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<IntroductionCubit>(create: (_) => IntroductionCubit()),
          BlocProvider(
            create: (_) =>
                NowPlayingMoviesBloc(MovieHomeRepositoryImpl.create()),
          ),
          BlocProvider(
            create: (_) =>
                ComingSoonMoviesBloc(MovieHomeRepositoryImpl.create()),
          ),
          BlocProvider(
            create: (_) => MovieDetailBloc(MovieDetailRepositoryImpl.create()),
          ),
          BlocProvider(
            create: (_) => RegisterBloc(AuthRepositoryImpl.create()),
          ),
          BlocProvider(
            create: (_) => LoginBloc(AuthRepositoryImpl.create()),
          ),
          BlocProvider(
            create: (_) => UserBloc(ProfileRepositoryImpl.create()),
          ),
          BlocProvider(
            create: (_) => LogoutBloc(AuthRepositoryImpl.create()),
          ),
          BlocProvider(
            create: (_) => LoginGoogleBloc(AuthRepositoryImpl.create()),
          ),
          BlocProvider(
            create: (_) => EditUserBloc(EditProfileRepositoryImpl.create()),
          ),
          BlocProvider(
            create: (_) => ChangePasswordBloc(ProfileRepositoryImpl.create()),
          ),
          BlocProvider(
            create: (_) => ForgotPasswordBloc(AuthRepositoryImpl.create()),
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
