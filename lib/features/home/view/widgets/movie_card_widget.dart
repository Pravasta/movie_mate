import 'package:movie_mate/core/extensions/date_time_ext.dart';
import 'package:movie_mate/core/variables/variable.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';

import '../../../../core/core.dart';
import '../../../../data/model/genre_model.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({super.key, required this.movie});

  final Result movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              '${Variable.baseImageUrl}${movie.posterPath}',
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.44,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            movie.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppText.text14.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.camera,
                  size: 18, color: AppColors.greyLightColor),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                    GenreModel.listGenres
                        .where((element) =>
                            movie.genreIds!.contains(element['id']))
                        .map((e) => e['name'] as String)
                        .toList()
                        .join(', '),
                    overflow: TextOverflow.ellipsis,
                    style: AppText.text12.copyWith(
                      color: AppColors.greyLightColor,
                    )),
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
                movie.releaseDate?.toFormattedDate() ?? '',
                style: AppText.text12.copyWith(color: AppColors.greyLightColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
