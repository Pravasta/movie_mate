import '../../core.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.title,
    this.titleColor = AppColors.blackColor,
    this.width = double.infinity,
    this.height = 40,
    this.backgroundColor,
    this.borderColor = AppColors.greyColor,
    required this.onTap,
    this.elevation = 3,
    this.iconUrl,
    this.borderRadius = 30,
  });

  final String title;
  final Color? titleColor;
  final double width, height;
  final Color? backgroundColor;
  final Color borderColor;
  final Function() onTap;
  final double elevation;
  final String? iconUrl;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
      ),
      onPressed: onTap,
      child: iconUrl != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconUrl!,
                  width: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: AppText.text16.copyWith(
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Text(
              title,
              style: AppText.text16.copyWith(
                color: titleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
