import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/features/watchlist_movie/bloc/get_watchlist_movie_bloc.dart';

import '../../../core/utils/route_observer.dart';

class WatchlistMoviePage extends StatefulWidget {
  const WatchlistMoviePage({super.key});

  @override
  State<WatchlistMoviePage> createState() => _WatchlistMoviePageState();
}

class _WatchlistMoviePageState extends State<WatchlistMoviePage>
    with RouteAware {
  @override
  void initState() {
    context
        .read<GetWatchlistMovieBloc>()
        .add(const GetWatchlistMovieEvent.getWatchlistMovie());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context
        .read<GetWatchlistMovieBloc>()
        .add(const GetWatchlistMovieEvent.getWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Movie'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: BlocBuilder<GetWatchlistMovieBloc, GetWatchlistMovieState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Center(
                  child: Text(
                    'You don\'t have a movie for show leter',
                    textAlign: TextAlign.center,
                    style: AppText.text16,
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(
                child: Text(
                  message,
                  style: AppText.text16,
                ),
              ),
              loaded: (data) {
                if (data.isEmpty) {
                  return Center(
                    child: Text(
                      'You don\'t have a movie for show leter',
                      textAlign: TextAlign.center,
                      style: AppText.text16,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final movie = data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigation.pushName(
                          RoutesName.detailPage,
                          arguments: movie['id'],
                        );
                      },
                      child: WatchlistMovieCard(movie: movie),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
