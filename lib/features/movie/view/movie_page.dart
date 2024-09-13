import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/features/home/bloc/coming_soon/coming_soon_movies_bloc.dart';

import '../../home/bloc/now_playing/now_playing_movies_bloc.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> page = ['Now Playing', 'Coming Soon'];

    Widget nowPlaying() {
      return BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(
              child: Text(message.message, style: AppText.text14),
            ),
            loaded: (data) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.47,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final movies = data[index];

                    return MovieWatchlistCardWidget(movies: movies);
                  },
                ),
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
            error: (message) => Center(
              child: Text(message.message, style: AppText.text14),
            ),
            loaded: (data) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.47,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final movies = data[index];

                    return MovieWatchlistCardWidget(movies: movies);
                  },
                ),
              );
            },
          );
        },
      );
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 30),
            child: TabBar(
                unselectedLabelColor: AppColors.greyLightColor,
                labelColor: AppColors.blackColor,
                labelStyle:
                    AppText.text16.copyWith(fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    AppText.text16.copyWith(fontWeight: FontWeight.bold),
                splashBorderRadius: BorderRadius.circular(15),
                labelPadding: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(15),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primaryColor,
                ),
                indicatorWeight: 0,
                dividerHeight: 0,
                tabs: page
                    .map(
                      (e) => Tab(text: e),
                    )
                    .toList()),
          ),
        ),
        body: TabBarView(children: [
          nowPlaying(),
          comingSoon(),
        ]),
      ),
    );
  }
}
