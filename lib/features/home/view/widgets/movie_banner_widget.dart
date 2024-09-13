import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/core/variables/variable.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';

import '../../../../data/model/genre_model.dart';

class MovieBannerWidget extends StatelessWidget {
  const MovieBannerWidget({super.key, required this.data});

  final Result data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image:
                    NetworkImage('${Variable.baseImageUrl}${data.posterPath}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          data.title ?? '',
          style: AppText.text20.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
            GenreModel.listGenres
                .where((element) => data.genreIds!.contains(element['id']))
                .map(
                  (e) => e['name'] as String,
                )
                .toList()
                .join(', '),
            textAlign: TextAlign.center,
            style: AppText.text12.copyWith(
              color: AppColors.greyLightColor,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: AppColors.primaryColor),
            const SizedBox(width: 5),
            Text('${data.voteAverage} (${data.voteCount})',
                style: AppText.text12),
          ],
        ),
      ],
    );
  }
}
