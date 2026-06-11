import 'package:flutter/material.dart';

import '../models/product.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'product_detail_screen.dart';

// Màn hình chính: quản lý 3 tab và dữ liệu dùng chung
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0; // 0: Home, 1: Product Detail, 2: Cart
  Product? selectedProduct; // Sản phẩm đang được chọn
  List<Product> cartList = []; // Danh sách sản phẩm trong giỏ hàng

  // Khi nhấn sản phẩm ở Home -> lưu sản phẩm và chuyển sang tab Product Detail
  void selectProduct(Product product) {
    setState(() {
      selectedProduct = product;
      currentTab = 1;
    });
  }

  // Thêm sản phẩm vào giỏ hàng
  void addToCart(Product product) {
    setState(() {
      cartList.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã thêm ${product.name} vào giỏ hàng')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentTab,
        children: [
          HomeScreen(onProductTap: selectProduct),
          ProductDetailScreen(
            product: selectedProduct,
            onAddToCart: addToCart,
          ),
          CartScreen(cartList: cartList),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            activeIcon: Icon(Icons.info),
            label: 'Product Detail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
