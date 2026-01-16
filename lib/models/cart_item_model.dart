class CartItem {
  final String productId;
  final String name;
  final int price;
  final int size;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.size,
    this.quantity = 1,
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

  factory CartItem.fromMap(Map<String, dynamic> map) => CartItem(
    productId: map['productId'],
    name: map['name'],
    price: map['price'],
    size: map['size'],
    quantity: map['quantity'],
    imageUrl: map['imageUrl'],
  );
}
