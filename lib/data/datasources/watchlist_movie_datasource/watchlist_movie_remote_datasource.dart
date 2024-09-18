import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';

import '../../../core/exception/exception.dart';

abstract class WatchlistMovieRemoteDatasource {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllWatchlistMovie();
  Future<void> insertWatchlistMovie(Result data);
  Future<void> deleteWatchlistMovie(int id);
  Future<Map<String, dynamic>?> getMovieById(int id);
}

class WatchlistMovieRemoteDatasourceImpl
    implements WatchlistMovieRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  WatchlistMovieRemoteDatasourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllWatchlistMovie() async {
    try {
      final currentUid = _firebaseAuth.currentUser!.uid;
      final database = await _firebaseFirestore
          .collection('users')
          .doc(currentUid)
          .collection('watchlist_movie')
          .get();
      return database;
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>?> getMovieById(int id) async {
    try {
      final currentUid = _firebaseAuth.currentUser!.uid;
      final database = await _firebaseFirestore
          .collection('users')
          .doc(currentUid)
          .collection('watchlist_movie')
          .doc(id.toString())
          .get();

      if (database.exists) {
        return database.data();
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<void> insertWatchlistMovie(Result data) async {
    try {
      final currentUid = _firebaseAuth.currentUser!.uid;
      final database = _firebaseFirestore
          .collection('users')
          .doc(currentUid)
          .collection('watchlist_movie')
          .doc(data.id.toString());
      await database.set(data.toLocalMap());
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<void> deleteWatchlistMovie(int id) async {
    try {
      final currentUid = _firebaseAuth.currentUser!.uid;
      final database = _firebaseFirestore
          .collection('users')
          .doc(currentUid)
          .collection('watchlist_movie')
          .doc(id.toString());
      await database.delete();
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  factory WatchlistMovieRemoteDatasourceImpl.create() {
    return WatchlistMovieRemoteDatasourceImpl(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
    );
  }
}
