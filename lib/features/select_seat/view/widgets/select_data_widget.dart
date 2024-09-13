import 'package:movie_mate/core/core.dart';

class SelectDataWidget extends StatelessWidget {
  const SelectDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            'Dec',
            style: AppText.text12.copyWith(
                color: AppColors.blackColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blackColor,
            ),
            child: Text('10',
                style: AppText.text14.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
