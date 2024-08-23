import 'package:movie_mate/features/detail_page/view/detail_page.dart';
import 'package:movie_mate/features/main_navigation/view/main_navigation_page.dart';
import 'package:movie_mate/features/register/view/register_page.dart';

import '../../core/import.dart';

class RoutesHandler {
  final String initialRoutes = RoutesName.initial;
  static const initialNavbarVisibility = true;

  static MaterialPageRoute get _emptyPage {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Text(
              'Not Found',
              style: AppText.text24.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.initial:
        return MaterialPageRoute(
          builder: (context) => const IntroductionPage(),
          settings: settings,
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: settings,
        );
      case RoutesName.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
          settings: settings,
        );
      case RoutesName.mainNavigation:
        return MaterialPageRoute(
          builder: (context) => const MainNavigationPage(),
          settings: settings,
        );
      case RoutesName.detailPage:
        return MaterialPageRoute(
          builder: (context) => const DetailPage(),
          settings: settings,
        );
      default:
        return _emptyPage;
    }
  }
}
