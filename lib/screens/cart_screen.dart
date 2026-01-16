import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    final total = cart.fold<int>(
      0,
          (sum, item) => sum + item.product.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cart.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_bag_outlined,
                size: 90, color: Colors.grey),
            SizedBox(height: 16),
            Text('Your cart is waiting for sneakers 👟'),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView(
              children: cart.map((item) {
                return ListTile(
                  title: Text(item.product.name),
                  subtitle: Text(
                      'Size ${item.size} • Qty ${item.quantity}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .removeItem(item);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CheckoutScreen(),
                  ),
                );
              },
              child: Text('CHECKOUT ₹$total'),
            ),
          ),
        ],
      ),
    );
  }
}
