import 'package:expandable_text/expandable_text.dart';
import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/features/detail_page/model/detail_page_model.dart';
import 'package:movie_mate/features/detail_page/view/widgets/actor_card_widget.dart';

import 'widgets/cinema_card_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    int cinemaButton = 0;

    Widget popUpTitle() {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.greySecondColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Avengers: Infinity War',
              style: AppText.text22.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              '2h29m - 16.12.2022',
              style: AppText.text12.copyWith(color: AppColors.greyLightColor),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Review ', style: AppText.text14),
                const Icon(Icons.star, color: AppColors.primaryColor, size: 20),
                Text('4.8 (1.222)', style: AppText.text14),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                for (int i = 0; i < 5; i++)
                  const Icon(Icons.star, size: 35, color: AppColors.greyColor),
                const SizedBox(width: 25),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.greyColor)),
                    child: Center(
                        child: Text('Add Watchlist', style: AppText.text12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget info() {
      var style = AppText.text12.copyWith(color: AppColors.greyLightColor);
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 5),
        height: MediaQuery.of(context).size.height * 1 / 10,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Movie Genre: ', style: style),
                Text('Censorship: ', style: style),
                Text('Language: ', style: style),
              ],
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Action, Adventure, sci-fi', style: AppText.text12),
                  Text('13+', style: AppText.text12),
                  Text('English', style: AppText.text12),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget storyline() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Storyline',
            style: AppText.text20.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ExpandableText(
            RandomText.randomText,
            maxLines: 4,
            expandText: 'See more',
            linkStyle: AppText.text12.copyWith(fontWeight: FontWeight.bold),
            linkColor: AppColors.primaryColor,
            style: AppText.text12.copyWith(color: AppColors.greyLightColor),
          ),
        ],
      );
    }

    Widget director() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Director',
            style: AppText.text20.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const ActorCardWidget(),
        ],
      );
    }

    Widget actor() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Actor',
            style: AppText.text20.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const ActorCardWidget(),
        ],
      );
    }

    Widget cinema() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cinema',
            style: AppText.text20.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: DetailPageModel.cinemaData
                    .map((e) => CinemaCardWidget(
                          title: e['title'],
                          distance: e['distance'],
                          location: e['location'],
                          isActive: cinemaButton == e['index'],
                          cinemaModel: e['cinema_model'],
                          onPressed: () =>
                              setState(() => cinemaButton = e['index']),
                        ))
                    .toList(),
              );
            },
          )
        ],
      );
    }

    return Scaffold(
      body: SizedBox(
        width: context.deviceWidth,
        height: context.deviceHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: context.deviceHeight,
                        height: context.deviceHeight * 0.29,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              Assets.images.banner.path,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: context.deviceHeight,
                        height: context.deviceHeight * 0.12,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          BackButton(color: AppColors.whiteColor),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: context.deviceHeight * 1 / 5,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: popUpTitle(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    info(),
                    const SizedBox(height: 20),
                    storyline(),
                    const SizedBox(height: 20),
                    director(),
                    const SizedBox(height: 20),
                    actor(),
                    const SizedBox(height: 20),
                    cinema(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: DefaultButton(
          title: 'Select Seat',
          height: 50,
          onTap: () => Navigation.pushName(RoutesName.selectSeat),
        ),
      ),
    );
  }
}
