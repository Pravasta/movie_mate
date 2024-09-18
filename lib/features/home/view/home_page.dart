import 'package:movie_mate/core/core.dart';
import 'package:badges/badges.dart' as badge;
import 'package:movie_mate/features/home/view/widgets/movie_banner_widget.dart';

import '../../profile/bloc/user/user_bloc.dart';
import '../bloc/coming_soon/coming_soon_movies_bloc.dart';
import '../bloc/now_playing/now_playing_movies_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context
        .read<NowPlayingMoviesBloc>()
        .add(const NowPlayingMoviesEvent.getNowPlayingMovies());
    context
        .read<ComingSoonMoviesBloc>()
        .add(const ComingSoonMoviesEvent.getComingSoonMovies());
    context.read<UserBloc>().add(const UserEvent.user());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget sectionTitle(String title) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          title,
          style: AppText.text18.copyWith(fontWeight: FontWeight.bold),
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
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const SizedBox(),
                      loading: () => Text(
                        'Loading...',
                        style: AppText.text14
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      loaded: (user) => Text('Hi, ${user.name}',
                          style: AppText.text14
                              .copyWith(fontWeight: FontWeight.w600)),
                    );
                  },
                ),
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
                Assets.icons.notification.path,
                color: AppColors.whiteColor,
                scale: 4,
              ),
            )
          ],
        ),
      );
    }

    Widget fieldSearch() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GestureDetector(
          onTap: () {
            Navigation.pushName(RoutesName.search);
          },
          child: const DefaultField(
            hintText: 'Search',
            isEnabled: false,
            backgroundColor: AppColors.greySecondColor,
            suffixIcon: Icon(Icons.search),
            inputType: TextInputType.emailAddress,
          ),
        ),
      );
    }

    Widget nowPlaying() {
      return BlocBuilder<HomeCubit, int>(
        builder: (context, currentIndex) {
          return BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox(),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (message) =>
                    Center(child: Text(message.message, style: AppText.text16)),
                loaded: (data) {
                  return Column(
                    children: [
                      CarouselSlider(
                        items: data
                            .map(
                              (e) => GestureDetector(
                                  onTap: () => Navigation.pushName(
                                        RoutesName.detailPage,
                                        arguments: e.id,
                                      ),
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
                        children: data.asMap().entries.map((entry) {
                          return Container(
                            width: 15,
                            height: 8,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: entry.key == 0 && currentIndex != 0
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12))
                                  : entry.key == data.length - 1 &&
                                          currentIndex != data.length - 1
                                      ? const BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12))
                                      : currentIndex == entry.key
                                          ? BorderRadius.circular(12)
                                          : null,
                              color: currentIndex == entry.key
                                  ? AppColors.primaryColor
                                  : AppColors.blackLightColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      );
    }

    Widget comingSoon() {
      return BlocBuilder<ComingSoonMoviesBloc, ComingSoonMoviesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) =>
                Center(child: Text(message.message, style: AppText.text14)),
            loaded: (data) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.42,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final movie = data[index];
                    return GestureDetector(
                        onTap: () => Navigation.pushName(
                              RoutesName.detailPage,
                              arguments: movie.id,
                            ),
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 15,
                            right: index == data.length - 1 ? 15 : 0,
                          ),
                          child: MovieCardWidget(movie: movie),
                        ));
                  },
                ),
              );
            },
          );
        },
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
              Assets.images.promo.path,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appbar(),
                  const SizedBox(height: 15),
                  fieldSearch(),
                  const SizedBox(height: 20),
                  sectionTitle('Now Playing'),
                  const SizedBox(height: 15),
                  nowPlaying(),
                  const SizedBox(height: 20),
                  sectionTitle('Coming Soon'),
                  const SizedBox(height: 15),
                  comingSoon(),
                  const SizedBox(height: 20),
                  sectionTitle('Promo & Discount'),
                  const SizedBox(height: 15),
                  promoDiscount(),
                  const SizedBox(height: 20),
                  sectionTitle('Service'),
                  const SizedBox(height: 15),
                  service(),
                  const SizedBox(height: 20),
                  sectionTitle('Movie News'),
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
