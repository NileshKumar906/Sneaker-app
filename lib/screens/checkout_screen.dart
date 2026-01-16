import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/cart_provider.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController();

  bool isPlacingOrder = false;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(title: const Text('Delivery Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (v) =>
                v == null || v.length < 10 ? 'Invalid phone' : null,
              ),
              TextFormField(
                controller: _addressCtrl,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _cityCtrl,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _pincodeCtrl,
                decoration: const InputDecoration(labelText: 'Pincode'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                v == null || v.length != 6 ? 'Invalid pincode' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isPlacingOrder
                    ? null
                    : () async {
                  if (!_formKey.currentState!.validate()) return;

                  setState(() => isPlacingOrder = true);

                  await FirebaseFirestore.instance
                      .collection('orders')
                      .add({
                    'userId': user.uid,
                    'items': cart.map((e) {
                      return {
                        'productId': e.product.id,
                        'name': e.product.name,
                        'size': e.size,
                        'qty': e.quantity,
                        'price': e.product.price,
                      };
                    }).toList(),
                    'address': {
                      'name': _nameCtrl.text.trim(),
                      'phone': _phoneCtrl.text.trim(),
                      'addressLine': _addressCtrl.text.trim(),
                      'city': _cityCtrl.text.trim(),
                      'pincode': _pincodeCtrl.text.trim(),
                    },
                    'status': 'placed',
                    'createdAt': FieldValue.serverTimestamp(),
                  });

                  ref.read(cartProvider.notifier).clearCart();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OrderSuccessScreen(),
                    ),
                        (route) => route.isFirst,
                  );

                },
                child: isPlacingOrder
                    ? const CircularProgressIndicator()
                    : const Text('PLACE ORDER'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
