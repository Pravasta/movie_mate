import 'package:movie_mate/core/import.dart';
import 'package:badges/badges.dart' as badge;
import 'package:movie_mate/features/home/view/widgets/movie_banner_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget sectionTitle(String title, {required Function() onTap}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Text(
              title,
              style: AppText.text18.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: Text('See all',
                  style:
                      AppText.text12.copyWith(color: AppColors.primaryColor)),
            )
          ],
        ),
      );
    }

    Widget appbar() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi, Pravasta',
                    style:
                        AppText.text14.copyWith(fontWeight: FontWeight.w600)),
                Text('Welcome Back',
                    style:
                        AppText.text18.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const Spacer(),
            badge.Badge(
              position: badge.BadgePosition.topEnd(top: 4, end: 4),
              badgeStyle: const badge.BadgeStyle(
                  padding: EdgeInsets.all(6),
                  badgeColor: AppColors.greenColor,
                  borderSide:
                      BorderSide(color: AppColors.blackColor, width: 2)),
              child: Image.asset(
                UrlAssets.notificationIcon,
                color: AppColors.whiteColor,
                scale: 4,
              ),
            )
          ],
        ),
      );
    }

    Widget fieldSearch() {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: DefaultField(
          hintText: 'Search',
          backgroundColor: AppColors.greySecondColor,
          suffixIcon: Icon(Icons.search),
          inputType: TextInputType.emailAddress,
        ),
      );
    }

    Widget nowPlaying() {
      return BlocBuilder<HomeCubit, int>(
        builder: (context, currentIndex) {
          return Column(
            children: [
              CarouselSlider(
                items: HomeModel.listBanner
                    .map(
                      (e) => GestureDetector(
                          onTap: () =>
                              Navigation.pushName(RoutesName.detailPage),
                          child: MovieBannerWidget(data: e)),
                    )
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  aspectRatio: 0.75,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: currentIndex,
                  onPageChanged: (index, reason) {
                    context.read<HomeCubit>().changeBanner(index);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: HomeModel.listBanner.asMap().entries.map((entry) {
                  return Container(
                    width: 15,
                    height: 8,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: entry.key == 0 && currentIndex != 0
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12))
                          : entry.key == HomeModel.listBanner.length - 1 &&
                                  currentIndex !=
                                      HomeModel.listBanner.length - 1
                              ? const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12))
                              : currentIndex == entry.key
                                  ? BorderRadius.circular(12)
                                  : null,
                      color: currentIndex == entry.key
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      );
    }

    Widget comingSoon() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.42,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => Navigation.pushName(RoutesName.detailPage),
                child: const MovieCardWidget());
          },
        ),
      );
    }

    Widget promoDiscount() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 27 / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                image: AssetImage(
              UrlAssets.promoImages,
            )),
          ),
        ),
      );
    }

    Widget service() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: HomeModel.listService
              .map((e) => ServiceCardWidget(data: e))
              .toList(),
        ),
      );
    }

    Widget movieNews() {
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.28,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return const MovieNewsCardWidget();
          },
        ),
      );
    }

    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  appbar(),
                  const SizedBox(height: 15),
                  fieldSearch(),
                  const SizedBox(height: 20),
                  sectionTitle('Now Playing', onTap: () {}),
                  const SizedBox(height: 15),
                  nowPlaying(),
                  const SizedBox(height: 20),
                  sectionTitle('Coming Soon', onTap: () {}),
                  const SizedBox(height: 15),
                  comingSoon(),
                  const SizedBox(height: 20),
                  sectionTitle('Promo & Discount', onTap: () {}),
                  const SizedBox(height: 15),
                  promoDiscount(),
                  const SizedBox(height: 20),
                  sectionTitle('Service', onTap: () {}),
                  const SizedBox(height: 15),
                  service(),
                  const SizedBox(height: 20),
                  sectionTitle('Movie News', onTap: () {}),
                  const SizedBox(height: 15),
                  movieNews(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
