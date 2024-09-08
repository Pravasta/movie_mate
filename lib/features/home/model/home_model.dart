import 'package:movie_mate/core/core.dart';

class HomeModel {
  static List<Map<String, dynamic>> listBanner = [
    {
      'images': Assets.images.banner.path,
      'title': 'Avengers - Infiniry War',
      'genre': 'Action, adventure, sci-fi',
      'duration': '2h29m',
      'rating': 4.8,
      'like_count': 1222,
    },
    {
      'images': Assets.images.bannerIntroImages2.path,
      'title': 'Avengers - End Game',
      'genre': 'Action, adventure, sci-fi',
      'duration': '3h15m',
      'rating': 4.9,
      'like_count': 5000,
    },
    {
      'images': Assets.images.bannerIntroImages3.path,
      'title': 'Thor - Love and Thunder',
      'genre': 'Action, adventure, sci-fi',
      'duration': '2h15m',
      'rating': 4.6,
      'like_count': 1000,
    },
    {
      'images': Assets.images.bannerIntroImages4.path,
      'title': 'Avengers',
      'genre': 'Action, adventure, sci-fi',
      'duration': '1h15m',
      'rating': 5.0,
      'like_count': 8000,
    }
  ];

  static List<Map<String, dynamic>> listService = [
    {
      'label': 'Retal',
      'images': Assets.images.retal.path,
    },
    {
      'label': 'Imax',
      'images': Assets.images.imax.path,
    },
    {
      'label': '4dx',
      'images': Assets.images.a4dx.path,
    },
    {
      'label': 'Sweetbox',
      'images': Assets.images.sweetbox.path,
    },
  ];
}
