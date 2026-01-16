import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

class CartItem {
  final Product product;
  final int size;
  int quantity;

  CartItem(this.product, this.size, this.quantity);
}

final cartProvider =
StateNotifierProvider<CartNotifier, List<CartItem>>(
      (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product, int size) {
    final index = state.indexWhere(
          (e) => e.product.id == product.id && e.size == size,
    );

    if (index >= 0) {
      state[index].quantity++;
      state = [...state];
    } else {
      state = [...state, CartItem(product, size, 1)];
    }
  }

  void removeItem(CartItem item) {
    state = state.where((e) => e != item).toList();
  }

  void clearCart() => state = [];
}
