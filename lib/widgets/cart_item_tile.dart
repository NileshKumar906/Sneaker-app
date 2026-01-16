import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartItemTile extends ConsumerWidget {
  final CartItem item;
  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = item.product;
    final image =
    product.images.isNotEmpty ? product.images.first : null;

    return ListTile(
      leading: image != null
          ? Image.network(
        image,
        width: 50,
        fit: BoxFit.cover,
      )
          : const SizedBox(width: 50),

      title: Text(product.name),
      subtitle: Text(
        'Size: ${item.size} • Qty: ${item.quantity}',
      ),

      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '₹${product.price * item.quantity}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref
                  .read(cartProvider.notifier)
                  .removeItem(item);
            },
          ),
        ],
      ),
    );
  }
}
