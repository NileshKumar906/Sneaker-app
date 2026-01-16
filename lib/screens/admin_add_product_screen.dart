import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminAddProductScreen extends StatefulWidget {
  const AdminAddProductScreen({super.key});

  @override
  State<AdminAddProductScreen> createState() =>
      _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  final _nameCtrl = TextEditingController();
  final _brandCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  final List<File> _images = [];
  bool isLoading = false;

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();

    if (picked != null) {
      setState(() {
        _images.addAll(picked.map((e) => File(e.path)));
      });
    }
  }

  Future<List<String>> uploadImages(String productId) async {
    List<String> urls = [];

    for (int i = 0; i < _images.length; i++) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('products/$productId/img_$i.jpg');

      await ref.putFile(_images[i]);
      urls.add(await ref.getDownloadURL());
    }

    return urls;
  }

  Future<void> addProduct() async {
    setState(() => isLoading = true);

    final productRef =
    FirebaseFirestore.instance.collection('products').doc();

    final imageUrls = await uploadImages(productRef.id);

    await productRef.set({
      'name': _nameCtrl.text.trim(),
      'brand': _brandCtrl.text.trim(),
      'price': int.parse(_priceCtrl.text),
      'description': _descCtrl.text.trim(),
      'images': imageUrls,
      'sizes': [7, 8, 9, 10],
      'createdAt': FieldValue.serverTimestamp(),
    });

    setState(() => isLoading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: _brandCtrl, decoration: const InputDecoration(labelText: 'Brand')),
            TextField(controller: _priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price')),
            TextField(controller: _descCtrl, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: pickImages,
              child: const Text('Pick Images'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : addProduct,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('ADD PRODUCT'),
            ),
          ],
        ),
      ),
    );
  }
}
