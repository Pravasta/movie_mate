import 'package:movie_mate/core/core.dart';

class ProfileModel {
  static List<Map<String, dynamic>> listMenu = [
    {
      'icon': Assets.icons.myTicker,
      'label': 'My Ticket',
    },
    {
      'icon': Assets.icons.shoppingCart,
      'label': 'Payment History',
    },
    {
      'icon': Assets.icons.translate,
      'label': 'Change Language',
    },
    {
      'icon': Assets.icons.lock,
      'label': 'Change Password',
    },
    {
      'icon': Assets.icons.faceId,
      'label': 'Face ID / Touch ID',
    },
  ];
}
