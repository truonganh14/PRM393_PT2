import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/price_formatter.dart';

// Màn hình Product Detail: hiển thị chi tiết sản phẩm đã chọn
class ProductDetailScreen extends StatelessWidget {
  final Product? product;
  final Function(Product)? onAddToCart;

  const ProductDetailScreen({
    super.key,
    this.product,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product?.name ?? 'Product Detail'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: product == null ? buildEmptyView() : buildDetailView(context),
    );
  }

  // Hiển thị khi chưa chọn sản phẩm
  Widget buildEmptyView() {
    return const Center(
      child: Text(
        'Chọn sản phẩm ở tab Home',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  // Hiển thị chi tiết sản phẩm
  Widget buildDetailView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ảnh sản phẩm
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    product!.image,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),

                // Tên sản phẩm
                Text(
                  product!.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Mô tả sản phẩm
                const Text(
                  'Mô tả sản phẩm',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  product!.description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),

                // Giá gốc (nếu có giảm giá)
                if (product!.discountPercent > 0)
                  Text(
                    formatPrice(product!.price),
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),

                // Giá sau giảm
                Text(
                  formatPrice(product!.discountedPrice),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: product!.discountPercent > 0
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Nút Add to cart
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => onAddToCart?.call(product!),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to cart'),
            ),
          ),
        ),
      ],
    );
  }
}
