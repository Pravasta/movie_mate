import 'package:movie_mate/core/import.dart';

Future<dynamic> introBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Choose language', style: AppText.text28),
              Text(
                'Which language do you want to use?',
                style: AppText.text12.copyWith(color: AppColors.greyLightColor),
              ),
              Radio.adaptive(
                value: 100,
                groupValue: 100,
                onChanged: (value) {},
              ),
              Radio.adaptive(
                value: 100,
                groupValue: 100,
                onChanged: (value) {},
              )
            ],
          ),
        ),
      );
    },
  );
}
