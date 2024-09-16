import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_mate/core/exception/api_exception.dart';
import 'package:movie_mate/data/model/request/login_request_model.dart';
import 'package:movie_mate/data/model/request/register_request_model.dart';
import 'package:movie_mate/data/model/response/user_response_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserResponseModel> login(LoginRequestModel data);
  Future<UserResponseModel> register(RegisterRequestModel data);
  Future<void> forgotPassword(String email);
  Future<void> changePassword(String password);
  Future<bool> logout();
  Future<void> setUser(UserResponseModel user);
  Future<UserResponseModel> googleSignIn();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteDatasourceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<void> changePassword(String password) async {
    try {
      await _auth.currentUser!.updatePassword(password);

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({'password': password});
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UserResponseModel> login(LoginRequestModel data) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );

      if (credential.user!.emailVerified == true) {
        _firestore.collection('users').doc(credential.user!.uid).update({
          'isVerified': true,
        });
      } else {
        throw ApiException(message: 'Please check Email for Verification');
      }

      final UserResponseModel user = UserResponseModel(
        email: data.email,
        password: data.password,
        uid: credential.user!.uid,
        isVerified: credential.user!.emailVerified,
        photoUrl: credential.user!.photoURL,
        name: credential.user?.displayName,
      );

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ApiException(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ApiException(message: 'Wrong password provided for that user.');
      } else {
        throw ApiException(message: '${e.message}');
      }
    } catch (e) {
      throw ApiException(message: '$e');
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserResponseModel> register(RegisterRequestModel data) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );

      final user = UserResponseModel(
        uid: credential.user!.uid,
        name: data.name,
        email: data.email,
        password: data.password,
        isVerified: credential.user!.emailVerified,
        photoUrl: credential.user!.photoURL,
        phoneNumber: credential.user!.phoneNumber,
      );

      await credential.user!.sendEmailVerification();

      await setUser(user);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ApiException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ApiException(
            message: 'The account already exists for that email.');
      }
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<void> setUser(UserResponseModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'isVerified': user.isVerified,
        'photoUrl': user.photoUrl,
        'phoneNumber': user.phoneNumber,
      });
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UserResponseModel> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      await googleSignIn.disconnect();
    } catch (_) {}

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final user = await _auth.signInWithCredential(credential);

      // Check user exist or not
      final currentData =
          await _firestore.collection('users').doc(user.user!.uid).get();

      final UserResponseModel userData = UserResponseModel(
        email: user.user!.email,
        name: user.user!.displayName,
        phoneNumber: user.user!.phoneNumber,
        photoUrl: user.user!.photoURL,
        uid: user.user!.uid,
        isVerified: user.user!.emailVerified,
      );

      if (!currentData.exists) {
        await setUser(userData);
      }

      return userData;
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  factory AuthRemoteDatasourceImpl.create() {
    return AuthRemoteDatasourceImpl(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    );
  }
}
