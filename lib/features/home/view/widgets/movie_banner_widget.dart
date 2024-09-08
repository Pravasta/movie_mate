import 'package:movie_mate/core/core.dart';

class MovieBannerWidget extends StatelessWidget {
  const MovieBannerWidget({super.key, required this.data});

  final Map<String, dynamic> data;

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
                image: AssetImage(data['images']),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          data['title'],
          style: AppText.text20.copyWith(fontWeight: FontWeight.bold),
        ),
        Text('${data['duration']} - ${data['genre']}',
            style: AppText.text12.copyWith(
              color: AppColors.greyLightColor,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: AppColors.primaryColor),
            const SizedBox(width: 5),
            Text('${data['rating']} (${data['like_count']})',
                style: AppText.text12),
          ],
        ),
      ],
    );
  }
}
