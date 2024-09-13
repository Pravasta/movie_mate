import 'package:movie_mate/core/core.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.greySecondColor,
          border: Border.all(
            width: 1.5,
            color: AppColors.primaryColor,
          )),
      child: Text('14:15', style: AppText.text16),
    );
  }
}
