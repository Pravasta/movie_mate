import 'package:movie_mate/core/import.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget appBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'MOVIEMate',
            style: AppText.text20.copyWith(color: AppColors.primaryColor),
          ),
          GestureDetector(
            onTap: () {
              introBottomSheet(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 1, color: AppColors.greyLightColor),
              ),
              child: Row(
                children: [
                  Image.asset(
                    UrlAssets.translateIcon,
                    scale: 6,
                    color: AppColors.greyLightColor,
                  ),
                  const SizedBox(width: 2),
                  Text('English',
                      style: AppText.text12.copyWith(
                          color: AppColors.greyLightColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget content() {
      return BlocProvider<ChangeBannerCubit>(
        create: (context) => ChangeBannerCubit(),
        child: BlocBuilder<ChangeBannerCubit, int>(
          builder: (context, currentIndex) {
            return Container(
              margin: const EdgeInsets.all(18),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 3 / 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 8),
                  CarouselSlider(
                    items: IntroductionModel.imagesSlider
                        .map(
                          (e) => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(e),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      aspectRatio: 1,
                      enlargeCenterPage: true,
                      initialPage: currentIndex,
                      onPageChanged: (index, reason) {
                        context.read<ChangeBannerCubit>().changeBanner(index);
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'MOVIEMate hello!',
                        style: AppText.text26
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'enjoy your favorite movies',
                        style: AppText.text12,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: IntroductionModel.imagesSlider
                            .asMap()
                            .entries
                            .map((entry) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == entry.key
                                  ? AppColors.primaryColor
                                  : AppColors.greyColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    Widget footer() {
      return Expanded(
        child: Column(
          children: [
            DefaultButton(
                title: 'Sign In',
                onTap: () => Navigation.pushName(RoutesName.login),
                height: 56),
            const SizedBox(height: 12),
            DefaultButton(
              title: 'Sign Up',
              onTap: () {},
              titleColor: AppColors.whiteColor,
              height: 56,
              backgroundColor: AppColors.blackColor,
            ),
            const SizedBox(height: 20),
            Text(
              'By sign in or sign up, you agree to our Terms of Service\nand Privac y Policy',
              textAlign: TextAlign.center,
              style: AppText.text10.copyWith(color: AppColors.greyLightColor),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              appBar(),
              content(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
