import 'package:movie_mate/core/core.dart';

class DirectorCardWidget extends StatelessWidget {
  const DirectorCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1 / 3,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: AppColors.greySecondColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  Assets.images.avatar.path,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              'Robert Downey Jr.',
              style: AppText.text12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
