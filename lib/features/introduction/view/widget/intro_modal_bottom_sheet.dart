import 'package:movie_mate/core/import.dart';
import 'package:movie_mate/features/introduction/cubit/introduction_state.dart';

Future<dynamic> introBottomSheet(BuildContext context) {
  final listLanguage = IntroductionModel.listLanguage;

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return BlocBuilder<IntroductionCubit, IntroductionState>(
        key: const Key('change-language'),
        builder: (context, state) {
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
                    style: AppText.text12
                        .copyWith(color: AppColors.greyLightColor),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: listLanguage
                        .map(
                          (e) => Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  e['title'],
                                  style: AppText.text20.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: e['value'] == state.languageIndex
                                        ? AppColors.primaryColor
                                        : AppColors.whiteColor,
                                  ),
                                ),
                                trailing: Radio<int>(
                                  value: e['value'],
                                  activeColor: AppColors.primaryColor,
                                  groupValue: state.languageIndex,
                                  onChanged: (value) {
                                    context
                                        .read<IntroductionCubit>()
                                        .changeLanguage(value!);
                                  },
                                ),
                              ),
                              e['value'] == listLanguage.length - 1
                                  ? const SizedBox()
                                  : const Divider(
                                      thickness: 0.1,
                                      color: AppColors.greyLightColor),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  const Spacer(),
                  DefaultButton(
                    title: 'Change Language',
                    height: 56,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
