import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/order_service.dart';
import '../models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/firebase_providers.dart';

final userOrdersProvider = StreamProvider.autoDispose<List<Order>>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  final user = auth.currentUser;
  if (user == null) return const Stream.empty();
  final os = ref.read(orderServiceProvider);
  return os.getOrdersForUser(user.uid);
});

// place order action
final orderActionsProvider = Provider((ref) {
  final os = ref.read(orderServiceProvider);
  final auth = ref.read(firebaseAuthProvider);
  return OrderActions(os, auth);
});

class OrderActions {
  final OrderService _service;
  final FirebaseAuth _auth;
  OrderActions(this._service, this._auth);

  Future<void> placeOrder(Order order) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Not logged in');
    await _service.placeOrder(order: order);
  }
}
