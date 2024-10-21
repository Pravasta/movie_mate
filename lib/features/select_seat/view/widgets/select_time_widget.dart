import 'package:movie_mate/core/core.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({
    super.key,
    required this.isActive,
    required this.onPressed,
    required this.title,
  });

  final bool isActive;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.greySecondColor,
            border: Border.all(
              width: 1.5,
              color:
                  isActive ? AppColors.primaryColor : AppColors.greySecondColor,
            )),
        child: Text(
          title,
          style: AppText.text16.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
