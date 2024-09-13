import 'package:movie_mate/features/my_ticket/view/my_ticket_page.dart';

import '../../core.dart';

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
        final id = settings.arguments;
        if (id == null || id is! int) return _emptyPage;
        return MaterialPageRoute(
          builder: (context) => DetailPage(id: id),
          settings: settings,
        );
      case RoutesName.selectSeat:
        return MaterialPageRoute(
          builder: (context) => const SelectSeatPage(),
          settings: settings,
        );
      case RoutesName.payment:
        return MaterialPageRoute(
          builder: (context) => const PaymentPage(),
          settings: settings,
        );
      case RoutesName.myTicket:
        return MaterialPageRoute(
          builder: (context) => const MyTicketPage(),
          settings: settings,
        );
      default:
        return _emptyPage;
    }
  }
}
