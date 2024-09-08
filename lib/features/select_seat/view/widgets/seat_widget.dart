import 'package:movie_mate/core/core.dart';

class SeatWidget extends StatelessWidget {
  const SeatWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth * 1 / 14,
      height: context.deviceWidth * 1 / 14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.blackLightColor,
      ),
      child: Center(
        child: Text(
          title,
          style: AppText.text10.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
