import 'package:movie_mate/core/core.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.isActive,
    required this.onPressed,
  });

  final String title;
  final String imageUrl;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: context.deviceWidth,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.greySecondColor,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(
                  color: AppColors.primaryColor,
                  width: 1,
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: context.deviceWidth * 1 / 4,
              height: context.deviceWidth * 1 / 7,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.whiteColor,
              ),
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: AppText.text14.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
