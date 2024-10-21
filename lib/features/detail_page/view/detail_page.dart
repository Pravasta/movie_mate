import 'package:expandable_text/expandable_text.dart';
import 'package:movie_mate/core/components/message/message_bar.dart';
import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/core/extensions/date_time_ext.dart';
import 'package:movie_mate/core/variables/variable.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';
import 'package:movie_mate/data/model/response/order_model.dart';
import 'package:movie_mate/features/detail_page/bloc/bloc/crud_watchlist_movie_bloc.dart';
import 'package:movie_mate/features/detail_page/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_mate/features/detail_page/model/detail_page_model.dart';
import 'package:movie_mate/features/detail_page/view/widgets/director_card_widget.dart';

import '../../../data/model/response/movie_detail_response_model.dart';
import 'widgets/cinema_card_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});

  final int id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context
        .read<MovieDetailBloc>()
        .add(MovieDetailEvent.getMovieDetail(widget.id));
    context
        .read<CrudWatchlistMovieBloc>()
        .add(CrudWatchlistMovieEvent.isAddedWatchlistMovie(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int cinemaButton = 0;

    String title = '';
    String duration = '';
    List<String> genres = [];
    String cinemaLocation = '';
    String cinemaName = '';
    String imageUrl = '';

    Widget popUpTitle(MovieDetailResponseModel data) {
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
              data.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.text22.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              '2h29m - ${data.releaseDate?.toFormattedDate()}',
              style: AppText.text12.copyWith(color: AppColors.greyLightColor),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Review ', style: AppText.text14),
                const Icon(Icons.star, color: AppColors.primaryColor, size: 20),
                Text('${data.voteAverage} (${data.voteCount})',
                    style: AppText.text14),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                for (int i = 0; i < 5; i++)
                  const Icon(Icons.star, size: 35, color: AppColors.greyColor),
                const SizedBox(width: 25),
                Expanded(
                  child: BlocConsumer<CrudWatchlistMovieBloc,
                      CrudWatchlistMovieState>(
                    listenWhen: (previous, current) {
                      final messagePrevious = previous.maybeWhen(
                        orElse: () {},
                        success: (message) => message,
                      );
                      final messageCurrent = previous.maybeWhen(
                        orElse: () {},
                        success: (message) => message,
                      );

                      return messagePrevious != messageCurrent ||
                          messagePrevious != '';
                    },
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        error: (message) =>
                            MessageBar.messageBar(context, message),
                        success: (message) =>
                            MessageBar.messageBar(context, message),
                      );
                    },
                    builder: (context, state) {
                      final states = state.maybeWhen(
                        orElse: () {},
                        isAdded: (isAdded) => isAdded,
                      );

                      return state.maybeWhen(
                        orElse: () {
                          return GestureDetector(
                            onTap: () {
                              final dataMovie = Result(
                                id: data.id,
                                overview: data.overview,
                                popularity: data.popularity,
                                posterPath: data.posterPath,
                                title: data.title,
                                voteAverage: data.voteAverage,
                                voteCount: data.voteCount,
                              );

                              if (states == false) {
                                context.read<CrudWatchlistMovieBloc>().add(
                                      CrudWatchlistMovieEvent.addWatchlistMovie(
                                          dataMovie),
                                    );
                              } else {
                                context.read<CrudWatchlistMovieBloc>().add(
                                      CrudWatchlistMovieEvent
                                          .removeWatchlistMovie(data.id!),
                                    );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: states == false
                                      ? AppColors.blackColor
                                      : AppColors.primaryDarkColor,
                                  border: Border.all(
                                    color: states == false
                                        ? AppColors.greyColor
                                        : AppColors.primaryColor,
                                  )),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    states == false ? Icons.add : Icons.check,
                                    color: states == false
                                        ? AppColors.whiteColor
                                        : AppColors.primaryColor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text('Add Watchlist',
                                      style: AppText.text12.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: states == false
                                            ? AppColors.whiteColor
                                            : AppColors.primaryColor,
                                      ))
                                ],
                              )),
                            ),
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget info(MovieDetailResponseModel data) {
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
                  Text(
                    '${data.genres?.map((e) => e.name).join(', ')}',
                    style: AppText.text12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(data.adult == false ? '13+' : '18+',
                      style: AppText.text12),
                  Text('English', style: AppText.text12),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget storyline(MovieDetailResponseModel data) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Storyline',
            style: AppText.text20.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ExpandableText(
            data.overview ?? '',
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
          const DirectorCardWidget(),
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
                          onPressed: () => setState(() {
                            cinemaButton = e['index'];
                            cinemaName = e['title'];
                            cinemaLocation = e['location'];
                          }),
                        ))
                    .toList(),
              );
            },
          )
        ],
      );
    }

    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error) => Center(
              child: Text(error.message, style: AppText.text14),
            ),
            loaded: (data) {
              title = data.title ?? '';
              duration = '2h29m';
              genres = data.genres!.map((e) => e.name!).toList();
              imageUrl = data.posterPath!;

              return SizedBox(
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
                                    image: data.posterPath == null
                                        ? AssetImage(Assets.images.banner.path)
                                        : NetworkImage(
                                            '${Variable.baseImageUrl}${data.posterPath}',
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
                                  BackButton(
                                    color: AppColors.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: context.deviceHeight * 1 / 5,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: popUpTitle(data),
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
                            info(data),
                            const SizedBox(height: 20),
                            storyline(data),
                            const SizedBox(height: 20),
                            director(),
                            const SizedBox(height: 20),
                            cinema(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: DefaultButton(
          title: 'Select Seat',
          height: 50,
          onTap: () {
            final orderData = OrderModel(
              orderId: DateTime.now().microsecondsSinceEpoch.toString(),
              cinemaLocation: cinemaLocation,
              title: title,
              image: imageUrl,
              duration: duration,
              genres: genres,
              cinemaName: cinemaName,
            );
            Navigation.pushName(
              RoutesName.selectSeat,
              arguments: orderData,
            );
          },
        ),
      ),
    );
  }
}
