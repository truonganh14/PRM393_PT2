import 'package:flutter/material.dart';

import '../dao/product_dao.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

// Màn hình Home: tìm kiếm + hiển thị danh sách sản phẩm
class HomeScreen extends StatefulWidget {
  final Function(Product) onProductTap;

  const HomeScreen({super.key, required this.onProductTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final productDAO = ProductDAO();
  final searchController = TextEditingController();
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    productList = productDAO.getAllProduct();
    searchController.addListener(searchProduct);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Lọc sản phẩm khi người dùng gõ vào ô Search
  void searchProduct() {
    setState(() {
      productList = productDAO.searchProducts(searchController.text);
    });
  }

  // Tính số cột hiển thị theo chiều rộng và hướng màn hình
  int getColumnCount(double width, Orientation orientation) {
    if (width <= 500) {
      return orientation == Orientation.portrait ? 1 : 2;
    }
    return orientation == Orientation.portrait ? 2 : 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Ô tìm kiếm
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search product',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Danh sách sản phẩm dạng lưới
          Expanded(
            child: productList.isEmpty
                ? const Center(child: Text('Không tìm thấy sản phẩm'))
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final columnCount = getColumnCount(
                        constraints.maxWidth,
                        MediaQuery.of(context).orientation,
                      );

                      return GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columnCount,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: columnCount == 1 ? 1.45 : 0.82,
                        ),
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          final product = productList[index];

                          return ProductCard(
                            product: product,
                            onTap: () => widget.onProductTap(product),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
