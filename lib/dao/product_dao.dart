import '../models/product.dart';

// ProductDAO: quản lý dữ liệu sản phẩm (tạm lưu trong bộ nhớ)
class ProductDAO {
  // Danh sách sản phẩm mẫu
  final List<Product> _products = const [
    Product(
      id: 1,
      name: 'iPhone 15',
      description: 'Smartphone Apple iPhone 15',
      price: 21990000,
      discountPercent: 5,
      image: 'assets/images/iphone15.png',
    ),
    Product(
      id: 2,
      name: 'Samsung Galaxy S24',
      description: 'Smartphone Samsung Galaxy S24',
      price: 19990000,
      discountPercent: 10,
      image: 'assets/images/galaxy_s24.png',
    ),
    Product(
      id: 3,
      name: 'MacBook Air M3',
      description: 'Laptop Apple MacBook Air chip M3',
      price: 27990000,
      discountPercent: 0,
      image: 'assets/images/macbook_air_m3.png',
    ),
  ];

  // Lấy tất cả sản phẩm
  List<Product> getAllProduct() {
    return _products;
  }

  // Tìm sản phẩm theo tên (khớp chính xác)
  Product? findProductByName(String name) {
    final keyword = name.trim().toLowerCase();

    for (final product in _products) {
      if (product.name.toLowerCase() == keyword) {
        return product;
      }
    }

    return null;
  }

  // Tìm sản phẩm theo từ khóa (dùng cho ô Search)
  List<Product> searchProducts(String keyword) {
    final query = keyword.trim().toLowerCase();

    if (query.isEmpty) {
      return getAllProduct();
    }

    final result = <Product>[];

    for (final product in _products) {
      if (product.name.toLowerCase().contains(query)) {
        result.add(product);
      }
    }

    return result;
  }
}
