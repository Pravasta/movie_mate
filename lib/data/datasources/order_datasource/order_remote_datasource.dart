import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_mate/data/model/response/order_model.dart';

import '../../../core/exception/exception.dart';

abstract class OrderRemoteDatasource {
  Future<void> createOrderMovie(OrderModel order);
  Future<List<OrderModel>> getAllOrder();
}

class OrderRemoteDatasourceImpl implements OrderRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  OrderRemoteDatasourceImpl(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firebaseFirestore})
      : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  @override
  Future<void> createOrderMovie(OrderModel order) async {
    try {
      final currentUid = _firebaseAuth.currentUser!.uid;
      final orderDb = _firebaseFirestore
          .collection('users')
          .doc(currentUid)
          .collection('orders')
          .doc(order.orderId);
      await orderDb.set(order.toMap());
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<List<OrderModel>> getAllOrder() async {
    try {
      final currentUid = _firebaseAuth.currentUser!.uid;
      final orderList = await _firebaseFirestore
          .collection('users')
          .doc(currentUid)
          .collection('orders')
          .orderBy('orderId', descending: true)
          .get();
      final List<OrderModel> result = orderList.docs
          .map((e) => OrderModel.fromFirestore(e.data()))
          .toList();
      return result;
    } on FirebaseException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  factory OrderRemoteDatasourceImpl.create() {
    return OrderRemoteDatasourceImpl(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
    );
  }
}
