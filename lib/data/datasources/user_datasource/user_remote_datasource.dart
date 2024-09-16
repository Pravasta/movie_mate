import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_mate/data/model/request/edit_user_request_model.dart';

import '../../../core/exception/exception.dart';
import '../../model/response/user_response_model.dart';

abstract class UserRemoteDatasource {
  Future<UserResponseModel> getUser();
  Future<void> editUser(EditUserRequestModel data);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  UserRemoteDatasourceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  @override
  Future<UserResponseModel> getUser() async {
    try {
      final currUser = _auth.currentUser;
      final user =
          await _firestore.collection('users').doc(currUser!.uid).get();
      final data = UserResponseModel(
        uid: user['uid'],
        name: user['name'],
        email: user['email'],
        photoUrl: user['photoUrl'],
        isVerified: user['isVerified'],
        phoneNumber: user['phoneNumber'],
        password: user['password'],
      );

      return data;
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<void> editUser(EditUserRequestModel data) async {
    try {
      await _firestore.collection('users').doc(data.uid).update(data.toMap());
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  factory UserRemoteDatasourceImpl.create() {
    return UserRemoteDatasourceImpl(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    );
  }
}
