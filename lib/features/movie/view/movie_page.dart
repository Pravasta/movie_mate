import 'package:movie_mate/core/import.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> page = ['Now Playing', 'Coming Soon'];

    Widget nowPlaying() {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: 3,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.47,
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return const MovieWatchlistCardWidget();
          },
        ),
      );
    }

    Widget comingSoon() {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: 5,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.47,
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return const MovieWatchlistCardWidget();
          },
        ),
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
