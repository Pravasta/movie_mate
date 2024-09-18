import 'package:movie_mate/core/core.dart';

class MainNavigationModel {
  static List<Map<String, dynamic>> listBottomNavbar = [
    {
      'label': 'Home',
      'index': 0,
      'icon': Assets.icons.home.path,
    },
    {
      'label': 'Watchlist',
      'index': 1,
      'icon': Assets.icons.ticket.path,
    },
    {
      'label': 'Movie',
      'index': 2,
      'icon': Assets.icons.video.path,
    },
    {
      'label': 'Profile',
      'index': 3,
      'icon': Assets.icons.user.path,
    },
  ];

  static List<Widget> listPage = [
    const HomePage(),
    const WatchlistMoviePage(),
    const MoviePage(),
    const ProfilePage(),
  ];
}
