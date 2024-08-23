import '../../../../core/import.dart';

class MovieNewsCardWidget extends StatelessWidget {
  const MovieNewsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      width: MediaQuery.of(context).size.width * 2 / 3,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              UrlAssets.bannerMovieImages2,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 1 / 5,
              width: MediaQuery.of(context).size.width * 3 / 4,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              'When the Batman 2 Starts Filming Reportedly Revealed',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppText.text14.copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
