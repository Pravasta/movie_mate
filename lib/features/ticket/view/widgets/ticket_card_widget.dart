import 'package:movie_mate/core/import.dart';

class TicketCardWidget extends StatelessWidget {
  const TicketCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.greySecondColor,
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.asset(
              UrlAssets.bannerIntroImages,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 0.30,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Avengers: Infinity War',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        AppText.text16.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined,
                        color: AppColors.greyLightColor, size: 15),
                    Expanded(
                      child: Text(
                        '14h15\' + 16.12.2022',
                        style: AppText.text12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: AppColors.greyLightColor, size: 15),
                    Expanded(
                      child: Text(
                        'Vincom Ocean Park CGV',
                        style: AppText.text12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
