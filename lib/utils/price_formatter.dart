// Hàm dùng chung: định dạng giá tiền VNĐ
// Ví dụ: 21990000 -> "21.990.000 ₫"
String formatPrice(double price) {
  final text = price.toStringAsFixed(0);
  String result = '';

  for (int i = 0; i < text.length; i++) {
    if (i > 0 && (text.length - i) % 3 == 0) {
      result += '.';
    }
    result += text[i];
  }

  return '$result ₫';
}
