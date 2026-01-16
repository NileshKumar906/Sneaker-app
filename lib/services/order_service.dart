import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../core/firebase_providers.dart';
import '../models/order_model.dart';

final orderServiceProvider = Provider<OrderService>((ref) {
  final firestore = ref.read(firestoreProvider);
  return OrderService(firestore);
});

class OrderService {
  final FirebaseFirestore _firestore;
  OrderService(this._firestore);

  Future<void> placeOrder({required Order order}) async {
    await _firestore.collection(Constants.ordersCollection).add(order.toMap());
  }

  Stream<List<Order>> getOrdersForUser(String userId) {
    return _firestore
        .collection(Constants.ordersCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Order.fromMap(d.id, d.data())).toList());
  }
}
