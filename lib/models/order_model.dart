class OrderItem {
  final String productId;
  final String name;
  final int price;
  final int size;
  final int quantity;
  final String imageUrl;

  OrderItem({
  required this.productId,
  required this.name,
  required this.price,
  required this.size,
  required this.quantity,
  required this.imageUrl,

});
  Map<String, dynamic> toMap() => {
    'productId': productId,
    'name': name,
    'price': price,
    'size': size,
    'quantity': quantity,
    'imageUrl': imageUrl,
  };

  factory OrderItem.fromMap(Map<String, dynamic> map) => OrderItem(
    productId: map['productId'],
    name: map['name'],
    price: map['price'],
    size: map['size'],
    quantity: map['quantity'],
    imageUrl: map['imageUrl'],
  );
}
class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final int totalAmount;
  final DateTime createdAt;
  final String status;
  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.createdAt,
    this.status='pending',
});
  Map<String, dynamic> toMap() => {
    'userId': userId,
    'items': items.map((i) => i.toMap()).toList(),
    'totalAmount': totalAmount,
    'createdAt': createdAt.toIso8601String(),
    'status': status,
  };

  factory Order.fromMap(String id, Map<String, dynamic> map) => Order(
    id: id,
    userId: map['userId'],
    items: (map['items'] as List)
        .map((e) => OrderItem.fromMap(Map<String, dynamic>.from(e)))
        .toList(),
    totalAmount: map['totalAmount'],
    createdAt: DateTime.parse(map['createdAt']),
    status: map['status'] ?? 'pending',
  );
}