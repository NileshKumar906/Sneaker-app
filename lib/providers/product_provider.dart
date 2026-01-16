import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_sneakers/services/product_service.dart';

import '../models/product_model.dart';

final productsStreamProvider = StreamProvider<List<Product>>((ref){
  final service = ref.read(productServiceProvider);
  return service.getProductsStream();
});
final productDetailProvider=FutureProvider.family<Product, String>((ref, productId){
  final service=ref.read(productServiceProvider);
  return service.getProductById(productId);
});