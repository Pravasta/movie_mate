import '../../../../core/import.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      width: MediaQuery.of(context).size.width * 0.44,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              UrlAssets.movieImages,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.44,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Avatar 2: The Way of Water',
            style: AppText.text14.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.camera,
                  size: 18, color: AppColors.greyLightColor),
              const SizedBox(width: 5),
              Text(
                'Adventure, Sci-fi',
                style: AppText.text12.copyWith(color: AppColors.greyLightColor),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.calendar_month,
                  size: 18, color: AppColors.greyLightColor),
              const SizedBox(width: 5),
              Text(
                '20.12.2024',
                style: AppText.text12.copyWith(color: AppColors.greyLightColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
