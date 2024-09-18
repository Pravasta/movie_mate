import 'package:movie_mate/core/exception/database_exception.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';
import 'package:sqflite/sqflite.dart';

class MovieLocalDatasource {
  static MovieLocalDatasource? _movieLocalDatasource;
  static late Database _database;

  MovieLocalDatasource._internal() {
    _movieLocalDatasource = this;
  }

  factory MovieLocalDatasource() =>
      _movieLocalDatasource ?? MovieLocalDatasource._internal();

  static const _tblMovie = 'movies';

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = await openDatabase(
      '$path/favorite.db',
      onCreate: (db, version) async {
        await db.execute('''
              CREATE TABLE $_tblMovie (
                id INTEGER PRIMARY KEY,
                title TEXT,
                popularity REAL,
                posterPath TEXT,
                overview TEXT,
                voteAverage REAL,
                vouteCount INTEGER
              )
          ''');
      },
      version: 1,
    );
    return db;
  }

  Future<List<Result>> getAllMovie() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> data = await db.query(_tblMovie);

      return List.generate(
        data.length,
        (index) => Result.fromLocalMap(data[index]),
      );
    } on DatabaseException catch (e) {
      throw DbException(message: e.toString());
    } catch (e) {
      throw DbException(message: e.toString());
    }
  }

  Future<void> insertMovieFavorite(Result data) async {
    final db = await database;

    try {
      await db.insert(
        _tblMovie,
        data.toLocalMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on DatabaseException catch (e) {
      throw DbException(message: e.toString());
    } catch (e) {
      throw DbException(message: e.toString());
    }
  }

  Future<void> deleteMovieFavorite(int id) async {
    final db = await database;

    try {
      await db.delete(
        _tblMovie,
        where: 'id = ?',
        whereArgs: [id],
      );
    } on DatabaseException catch (e) {
      throw DbException(message: e.toString());
    } catch (e) {
      throw DbException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final result = await db.query(
      _tblMovie,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }
}
