import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/price_formatter.dart';

// Màn hình Cart: hiển thị sản phẩm đã thêm vào giỏ
class CartScreen extends StatelessWidget {
  final List<Product> cartList;

  const CartScreen({super.key, required this.cartList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: cartList.isEmpty ? buildEmptyCart() : buildCartList(),
    );
  }

  Widget buildEmptyCart() {
    return const Center(
      child: Text(
        'Giỏ hàng trống',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget buildCartList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: cartList.length,
      itemBuilder: (context, index) {
        final product = cartList[index];

        return Card(
          child: ListTile(
            leading: Image.asset(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Text(formatPrice(product.discountedPrice)),
          ),
        );
      },
    );
  }
}
