import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String brand;
  final int price;
  final String description;
  final List<String> images;
  final List<int> sizes;
  final Map<String, dynamic>? stock; // optional: size->qty

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.images,
    required this.sizes,
    this.stock,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    // create product object using data from firestore
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: (data['name'] ?? '') as String,
      brand: (data['brand'] ?? '') as String,
      price: (data['price'] ?? 0) as int,
      description: (data['description'] ?? '') as String,
      images: List<String>.from(data['images'] ?? []),
      sizes: List<int>.from(data['sizes'] ?? []),
      stock: data['stock'] != null ? Map<String, dynamic>.from(data['stock']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'price': price,
      'description': description,
      'images': images,
      'sizes': sizes,
      'stock': stock,
    };
  }
}
