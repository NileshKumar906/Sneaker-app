import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_sneakers/models/product_model.dart';

import '../core/constants.dart';
import '../core/firebase_providers.dart';

final productServiceProvider = Provider<ProductService>((ref){
  final firestore=ref.read(firestoreProvider);
  return ProductService(firestore);
});

class ProductService {
  final FirebaseFirestore _firestore;
  ProductService(this._firestore);

  Stream<List<Product>> getProductsStream(){
    return _firestore.collection(Constants.productsCollection).snapshots().map(
        (snap) => snap.docs.map((d) => Product.fromDocument(d)).toList()
    );
  }
  Future<void> addProduct(Product product){
    return _firestore.collection(Constants.productsCollection).add(product.toMap());
  }
  Future<Product> getProductById(String id)async{
    final doc=await _firestore.collection(Constants.productsCollection).doc(id).get();
    return Product.fromDocument(doc);
  }
}