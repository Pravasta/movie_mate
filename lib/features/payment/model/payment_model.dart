import 'package:movie_mate/core/core.dart';

class PaymentModel {
  static List<Map<String, dynamic>> paymentModel = [
    {
      'title': 'Shopee Pay',
      'image_url': Assets.icons.shopeePay.path,
      'index': 0,
    },
    {
      'title': 'Transfer Bank',
      'image_url': Assets.icons.atm.path,
      'index': 1,
    },
    {
      'title': 'Qris',
      'image_url': Assets.icons.qris.path,
      'index': 2,
    }
  ];
}
