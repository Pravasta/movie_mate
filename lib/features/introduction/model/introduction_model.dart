import 'package:movie_mate/core/core.dart';

class IntroductionModel {
  static List<String> imagesSlider = [
    Assets.images.banner.path,
    Assets.images.bannerIntroImages2.path,
    Assets.images.bannerIntroImages3.path,
    Assets.images.bannerIntroImages4.path,
  ];

  static List<Map<String, dynamic>> listLanguage = [
    {
      'value': 0,
      'title': 'English',
    },
    {
      'value': 1,
      'title': 'Indonesia',
    },
    {
      'value': 2,
      'title': 'Jawa',
    }
  ];
}
