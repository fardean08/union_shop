import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String imageUrl;
  final String price;
  final String? oldPrice;
  final String size;
  final String colour;
  int quantity;

  CartItem({
    required this.title,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    required this.size,
    required this.colour,
    required this.quantity,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice {
    return _items.fold(0.0, (sum, item) {
      final priceStr = item.price.replaceAll('£', '').replaceAll(',', '');
      final price = double.tryParse(priceStr) ?? 0.0;
      return sum + (price * item.quantity);
    });
  }

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((i) =>
        i.title == item.title && i.size == item.size && i.colour == item.colour);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity > 0) {
      _items[index].quantity = quantity;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}