import 'package:movie_mate/core/import.dart';

class HomeModel {
  static List<Map<String, dynamic>> listBanner = [
    {
      'images': UrlAssets.bannerIntroImages,
      'title': 'Avengers - Infiniry War',
      'genre': 'Action, adventure, sci-fi',
      'duration': '2h29m',
      'rating': 4.8,
      'like_count': 1222,
    },
    {
      'images': UrlAssets.bannerIntroImages2,
      'title': 'Avengers - End Game',
      'genre': 'Action, adventure, sci-fi',
      'duration': '3h15m',
      'rating': 4.9,
      'like_count': 5000,
    },
    {
      'images': UrlAssets.bannerIntroImages3,
      'title': 'Thor - Love and Thunder',
      'genre': 'Action, adventure, sci-fi',
      'duration': '2h15m',
      'rating': 4.6,
      'like_count': 1000,
    },
    {
      'images': UrlAssets.bannerIntroImages4,
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
      'images': UrlAssets.retalImages,
    },
    {
      'label': 'Imax',
      'images': UrlAssets.imaxImages,
    },
    {
      'label': '4dx',
      'images': UrlAssets.dxImages,
    },
    {
      'label': 'Sweetbox',
      'images': UrlAssets.sweetboxImages,
    },
  ];
}
