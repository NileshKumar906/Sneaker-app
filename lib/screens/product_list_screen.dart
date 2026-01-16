import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../providers/brand_filter_provider.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsStreamProvider);
    final selectedBrand = ref.watch(selectedBrandProvider);

    return productsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => Center(
        child: Text(e.toString()),
      ),
      data: (products) {
        // 🔥 Apply brand filter (if selected)
        final filteredProducts = selectedBrand == null
            ? products
            : products
            .where(
              (p) =>
          p.brand.toLowerCase() ==
              selectedBrand!.toLowerCase(),
        )
            .toList();

        if (filteredProducts.isEmpty) {
          return const Center(
            child: Text('No products found'),
          );
        }

        return ListView.builder(
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: filteredProducts[index],
            );
          },
        );
      },
    );
  }
}
