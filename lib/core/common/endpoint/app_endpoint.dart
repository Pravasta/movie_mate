import 'package:movie_mate/core/variables/variable.dart';

import '../../core.dart';

class AppEndpoint {
  final String _baseUrl;

  AppEndpoint({required String baseUrl}) : _baseUrl = baseUrl;

  Uri getNowPlayingMovies([int page = 1, String language = 'en-US']) {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '3/movie/now_playing',
      queryParameters: {
        'page': page,
        'language': language,
      },
    );
  }

  Uri getUpComingMovies([int page = 1, String language = 'en-US']) {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '3/movie/upcoming',
      queryParameters: {
        'page': page,
        'language': language,
      },
    );
  }

  Uri getDetailMovie(int id, {String language = 'en-US'}) {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '3/movie/$id',
      queryParameters: {
        'language': language,
      },
    );
  }

  Uri searchMovie(String query, {String language = 'en-US', int page = 1}) {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '3/search/movie',
      queryParameters: {
        'query': query,
        'language': language,
        'page': page,
      },
    );
  }

  factory AppEndpoint.create() {
    return AppEndpoint(baseUrl: Variable.baseUrl);
  }
}
