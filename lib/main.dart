import 'core/import.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Mate',
      theme: AppTheme.darkTheme,
      navigatorKey: navigatorKey,
      initialRoute: RoutesName.initial,
      onGenerateRoute: RoutesHandler.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
