import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/features/search/view/widgets/movie_card_list_widget.dart';

import '../bloc/search_movie_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchC;

  @override
  void initState() {
    searchC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: AppColors.whiteColor,
        ),
        title: DefaultField(
          suffixIcon: const Icon(Icons.search),
          hintText: 'Search',
          controller: searchC,
          inputType: TextInputType.text,
          onChanged: (value) {
            context
                .read<SearchMovieBloc>()
                .add(SearchMovieEvent.searchMovie(value));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Center(
                  child: Text(
                    "Let's Search our favorite Movies",
                    style: AppText.text16.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (movie) {
                if (movie.isEmpty && searchC.text.isNotEmpty) {
                  return Center(
                    child: Text(
                      "Movie Not Found",
                      style:
                          AppText.text16.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (movie.isEmpty && searchC.text.isEmpty) {
                  return Center(
                    child: Text(
                      "Let's Search our favorite Movies",
                      style:
                          AppText.text16.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: movie.length,
                    itemBuilder: (context, index) {
                      final data = movie[index];

                      return GestureDetector(
                        onTap: () => Navigation.pushName(
                          RoutesName.detailPage,
                          arguments: data.id,
                        ),
                        child: MovieCardListWidget(data: data),
                      );
                    },
                  );
                }
              },
              error: (message) =>
                  Center(child: Text(message, style: AppText.text16)),
            );
          },
        ),
      ),
    );
  }
}
