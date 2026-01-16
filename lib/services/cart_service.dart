import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/firebase_providers.dart';
import '../core/constants.dart';

final cartServiceProvider = Provider<CartService>((ref) {
  final firestore = ref.read(firestoreProvider);
  return CartService(firestore);
});

class CartService {
  final FirebaseFirestore _firestore;
  CartService(this._firestore);

  Future<void> addToCart({
    required String userId,
    required Map<String, dynamic> cartItemMap,
  }) async {
    final userDoc = _firestore.collection(Constants.usersCollection).doc(userId);
    final cartRef = userDoc.collection('cart');
    // push a new cart item doc
    await cartRef.add(cartItemMap);
  }

  Stream<List<Map<String, dynamic>>> getCartStream(String userId) {
    final cartRef = _firestore.collection(Constants.usersCollection).doc(userId).collection('cart');
    return cartRef.snapshots().map((snap) => snap.docs.map((d) {
      final m = d.data();
      m['_cartDocId'] = d.id;
      return m;
    }).toList());
  }

  Future<void> clearCart(String userId) async {
    final cartRef = _firestore.collection(Constants.usersCollection).doc(userId).collection('cart');
    final snap = await cartRef.get();
    final batch = _firestore.batch();
    for (final doc in snap.docs) batch.delete(doc.reference);
    await batch.commit();
  }

  Future<void> removeCartItem(String userId, String docId) {
    final docRef = _firestore.collection(Constants.usersCollection).doc(userId).collection('cart').doc(docId);
    return docRef.delete();
  }
}
