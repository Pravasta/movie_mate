import '../../core.dart';

class MessageBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> messageBar(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryDarkColor,
        content: Text(message, style: AppText.text14),
      ),
    );
  }
}
