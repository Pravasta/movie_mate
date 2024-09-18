import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/core/variables/variable.dart';

class WatchlistMovieCard extends StatelessWidget {
  const WatchlistMovieCard({super.key, required this.movie});

  final QueryDocumentSnapshot<Map<String, dynamic>> movie;

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
            child: movie['posterPath'] != null
                ? Image.network(
                    '${Variable.baseImageUrl}${movie['posterPath']}',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 0.30,
                  )
                : Image.asset(
                    Assets.images.banner.path,
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
                Text(movie['title'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        AppText.text16.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.star,
                        color: AppColors.primaryColor, size: 15),
                    const SizedBox(width: 5),
                    Text('${movie['voteAverage']} (${movie['voteCount']})',
                        style: AppText.text12),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: AppColors.greyLightColor, size: 15),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        movie['popularity'].toString(),
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
