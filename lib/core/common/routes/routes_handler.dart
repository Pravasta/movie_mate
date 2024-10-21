import 'package:movie_mate/data/model/response/order_model.dart';
import 'package:movie_mate/data/model/response/user_response_model.dart';
import 'package:movie_mate/features/edit_profile/view/edit_profile_page.dart';
import 'package:movie_mate/features/introduction/view/splash_page.dart';
import 'package:movie_mate/features/my_ticket/view/detail_ticket_page.dart';
import 'package:movie_mate/features/my_ticket/view/my_ticket_page.dart';
import 'package:movie_mate/features/search/view/search_page.dart';

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
          builder: (context) => const SplashPage(),
          settings: settings,
        );
      case RoutesName.intro:
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
        final orderData = settings.arguments;
        if (orderData == null || orderData is! OrderModel) {
          return _emptyPage;
        }
        return MaterialPageRoute(
          builder: (context) => SelectSeatPage(orderData: orderData),
          settings: settings,
        );
      case RoutesName.payment:
        final order = settings.arguments;
        if (order == null || order is! OrderModel) {
          return _emptyPage;
        }
        return MaterialPageRoute(
          builder: (context) => PaymentPage(order: order),
          settings: settings,
        );
      case RoutesName.detailTicket:
        final data = settings.arguments;
        if (data == null || data is! OrderModel) {
          return _emptyPage;
        }
        return MaterialPageRoute(
          builder: (context) => DetailTicketPage(data: data),
          settings: settings,
        );
      case RoutesName.editProfile:
        final data = settings.arguments;
        if (data == null || data is! UserResponseModel) return _emptyPage;
        return MaterialPageRoute(
          builder: (context) => EditProfilePage(data: data),
          settings: settings,
        );
      case RoutesName.search:
        return MaterialPageRoute(
          builder: (context) => const SearchPage(),
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
