import 'package:movie_mate/core/core.dart';

class ProfileModel {
  static List<Map<String, dynamic>> listMenu = [
    {
      'icon': Assets.icons.myTicker.path,
      'label': 'My Ticket',
    },
    {
      'icon': Assets.icons.shoppingCart.path,
      'label': 'Payment History',
    },
    {
      'icon': Assets.icons.translate.path,
      'label': 'Change Language',
    },
    {
      'icon': Assets.icons.lock.path,
      'label': 'Change Password',
    },
    {
      'icon': Assets.icons.faceId.path,
      'label': 'Face ID / Touch ID',
    },
  ];
}
