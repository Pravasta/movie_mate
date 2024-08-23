import 'package:movie_mate/core/import.dart';

class MovieWatchlistCardWidget extends StatelessWidget {
  const MovieWatchlistCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.pushName(RoutesName.detailPage),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.33,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(UrlAssets.movieImages),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 3),
                Text(
                  'Avatar 2: The Way of Water',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.text16.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.star,
                        size: 16, color: AppColors.primaryColor),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '4.0 (986)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.text12
                            .copyWith(color: AppColors.greyLightColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined,
                        size: 16, color: AppColors.greyLightColor),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '2 hours 5 minutes',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.text12
                            .copyWith(color: AppColors.greyLightColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.movie,
                        size: 16, color: AppColors.greyLightColor),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Adventure, Sci-fi',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.text12
                            .copyWith(color: AppColors.greyLightColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
