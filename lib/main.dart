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
            create: (context) => IntroductionCubit(),
          ),
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
