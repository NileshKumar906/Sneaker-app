import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final Map<String, dynamic> orderData;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.orderData,
  });

  int asInt(dynamic v, [int fallback = 0]) {
    if (v == null) return fallback;
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is num) return v.toInt();
    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    final List rawItems = orderData['items'] ?? [];
    final List<Map<String, dynamic>> items =
    rawItems.whereType<Map<String, dynamic>>().toList();

    final DateTime? createdAt =
    orderData['createdAt'] is Timestamp
        ? (orderData['createdAt'] as Timestamp).toDate()
        : null;

    final String status =
        orderData['status']?.toString() ?? 'placed';

    int total = 0;
    for (final item in items) {
      final int price = asInt(item['price']);
      final int qty = asInt(item['quantity'], 1);
      total += price * qty;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${orderId.substring(0, 6).toUpperCase()}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Status: ${status.toUpperCase()}'),
          if (createdAt != null)
            Text(
              'Placed on ${DateFormat('dd MMM yyyy, hh:mm a').format(createdAt)}',
              style: const TextStyle(color: Colors.grey),
            ),

          const Divider(height: 32),

          const Text(
            'Items',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          ...items.map((item) {
            final int price = asInt(item['price']);
            final int qty = asInt(item['quantity'], 1);
            final int lineTotal = price * qty;

            return ListTile(
              title:
              Text(item['name']?.toString() ?? 'Unknown product'),
              subtitle: Text(
                'Size: ${asInt(item['size'])} • Qty: $qty',
              ),
              trailing: Text('₹$lineTotal'),
            );
          }).toList(),

          const Divider(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '₹$total',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
