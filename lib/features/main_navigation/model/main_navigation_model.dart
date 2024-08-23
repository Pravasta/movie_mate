import 'package:movie_mate/core/import.dart';

class MainNavigationModel {
  static List<Map<String, dynamic>> listBottomNavbar = [
    {
      'label': 'Home',
      'index': 0,
      'icon': UrlAssets.homeIcon,
    },
    {
      'label': 'Ticket',
      'index': 1,
      'icon': UrlAssets.ticketIcon,
    },
    {
      'label': 'Movie',
      'index': 2,
      'icon': UrlAssets.videoIcon,
    },
    {
      'label': 'Profile',
      'index': 3,
      'icon': UrlAssets.userIcon,
    },
  ];

  static List<Widget> listPage = [
    const HomePage(),
    const TicketPage(),
    const MoviePage(),
    const ProfilePage(),
  ];
}
