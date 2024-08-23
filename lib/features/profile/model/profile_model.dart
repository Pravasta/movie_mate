import 'package:movie_mate/core/import.dart';

class ProfileModel {
  static List<Map<String, dynamic>> listMenu = [
    {
      'icon': UrlAssets.myTickerIcon,
      'label': 'My Ticket',
    },
    {
      'icon': UrlAssets.shoppingCartIcon,
      'label': 'Payment History',
    },
    {
      'icon': UrlAssets.translateIcon,
      'label': 'Change Language',
    },
    {
      'icon': UrlAssets.lockIcon,
      'label': 'Change Password',
    },
    {
      'icon': UrlAssets.faceIdIcon,
      'label': 'Face ID / Touch ID',
    },
  ];
}
