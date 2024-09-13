import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/core/variables/variable.dart';
import 'package:movie_mate/data/model/genre_model.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';

class MovieWatchlistCardWidget extends StatelessWidget {
  const MovieWatchlistCardWidget({super.key, required this.movies});

  final Result movies;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.pushName(
        RoutesName.detailPage,
        arguments: movies.id,
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.33,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  '${Variable.baseImageUrl}${movies.posterPath}',
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3),
                Text(
                  movies.title ?? '',
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
                        '${movies.voteAverage} (${movies.voteCount})',
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
                        GenreModel.listGenres
                            .where((element) =>
                                movies.genreIds!.contains(element['id']))
                            .map(
                              (e) => e['name'] as String,
                            )
                            .toList()
                            .join(', '),
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
