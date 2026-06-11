import 'package:flutter/material.dart';

import 'screens/main_screen.dart';

// Điểm bắt đầu của ứng dụng
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Mở màn hình chính có 3 tab: Home, Product Detail, Cart
      home: const MainScreen(),
    );
  }
}
