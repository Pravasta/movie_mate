import 'package:movie_mate/core/core.dart';

class CinemaCardWidget extends StatelessWidget {
  const CinemaCardWidget({
    super.key,
    required this.isActive,
    required this.title,
    required this.distance,
    required this.location,
    required this.cinemaModel,
    required this.onPressed,
  });

  final String title;
  final String distance;
  final String location;
  final String cinemaModel;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: context.deviceWidth,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.greySecondColor,
          border: isActive
              ? Border.all(
                  color: AppColors.primaryColor,
                  width: 1,
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppText.text14.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Image.asset(cinemaModel, scale: 4, fit: BoxFit.cover),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              '$distance | $location',
              style: AppText.text12.copyWith(color: AppColors.greyLightColor),
            ),
          ],
        ),
      ),
    );
  }
}
