import 'package:http/http.dart' as http;
import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/core/exception/exception.dart';
import 'package:movie_mate/core/variables/variable.dart';
import 'package:movie_mate/data/model/response/movie_detail_response_model.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';

abstract class MovieRemoteDatasource {
  Future<MovieResponseModel> getNowPlayingMovies();
  Future<MovieResponseModel> getUpComingMovies();
  Future<MovieDetailResponseModel> getDetailMovie(int id);
  Future<MovieResponseModel> searchMovie(String query);
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final AppEndpoint _appEndpoint;
  final http.Client _client;

  MovieRemoteDatasourceImpl({
    required AppEndpoint appEndpoint,
    required http.Client client,
  })  : _appEndpoint = appEndpoint,
        _client = client;

  @override
  Future<MovieResponseModel> getNowPlayingMovies() async {
    final header = {
      'Authorization': 'Bearer ${Variable.apiKey}',
      'accept': 'application/json',
    };
    final response = await _client.get(
      _appEndpoint.getNowPlayingMovies(),
      headers: header,
    );

    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(response.body);
    } else {
      throw ApiErrorHandler.handleError(
        statusCode: response.statusCode,
        error: ApiException(message: response.body).toString(),
      );
    }
  }

  @override
  Future<MovieResponseModel> getUpComingMovies() async {
    final header = {
      'Authorization': 'Bearer ${Variable.apiKey}',
      'accept': 'application/json',
    };
    final response = await _client.get(
      _appEndpoint.getUpComingMovies(),
      headers: header,
    );

    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(response.body);
    } else {
      throw ApiErrorHandler.handleError(
        statusCode: response.statusCode,
        error: ApiException(message: response.body).message.toString(),
      );
    }
  }

  @override
  Future<MovieDetailResponseModel> getDetailMovie(int id) async {
    final header = {
      'Authorization': 'Bearer ${Variable.apiKey}',
      'accept': 'application/json',
    };

    final response = await _client.get(
      _appEndpoint.getDetailMovie(id),
      headers: header,
    );

    if (response.statusCode == 200) {
      return MovieDetailResponseModel.fromJson(response.body);
    } else {
      throw ApiErrorHandler.handleError(
        statusCode: response.statusCode,
        error: ApiException(message: response.body).message.toString(),
      );
    }
  }

  @override
  Future<MovieResponseModel> searchMovie(String query) async {
    final header = {
      'Authorization': 'Bearer ${Variable.apiKey}',
      'accept': 'application/json',
    };

    final response = await _client.get(
      _appEndpoint.searchMovie(query),
      headers: header,
    );

    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(response.body);
    } else {
      throw ApiErrorHandler.handleError(
        statusCode: response.statusCode,
        error: ApiException(message: response.body).message.toString(),
      );
    }
  }

  factory MovieRemoteDatasourceImpl.create() {
    return MovieRemoteDatasourceImpl(
      appEndpoint: AppEndpoint.create(),
      client: http.Client(),
    );
  }
}
