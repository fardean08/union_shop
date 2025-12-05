import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartItem {
  final String id;                    // Unique identifier for cart item
  final String? productId;            // Reference to product (optional)
  final String title;
  final String imageUrl;
  final String price;
  final String? oldPrice;
  final String size;
  final String colour;
  int quantity;
  final DateTime addedAt;             // When item was added to cart
  String? notes;                      // Customer notes for this item
  final int? maxQuantity;             // Maximum quantity allowed
  final Map<String, dynamic>? metadata; // Additional custom data

  CartItem({
    String? id,
    this.productId,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    required this.size,
    required this.colour,
    required this.quantity,
    DateTime? addedAt,
    this.notes,
    this.maxQuantity,
    this.metadata,
  })  : id = id ?? const Uuid().v4(),
        addedAt = addedAt ?? DateTime.now();

  // Helper to get numeric price value
  double get numericPrice {
    final priceStr = price.replaceAll('£', '').replaceAll(',', '');
    return double.tryParse(priceStr) ?? 0.0;
  }

  // Helper to get numeric old price value
  double? get numericOldPrice {
    if (oldPrice == null) return null;
    final priceStr = oldPrice!.replaceAll('£', '').replaceAll(',', '');
    return double.tryParse(priceStr);
  }

  // Calculate total price for this item (price * quantity)
  double get totalPrice => numericPrice * quantity;

  // Check if item has a discount
  bool get hasDiscount => oldPrice != null && numericOldPrice != null;

  // Calculate discount amount
  double get discountAmount {
    if (!hasDiscount) return 0.0;
    return (numericOldPrice! - numericPrice) * quantity;
  }

  // Calculate discount percentage
  double get discountPercentage {
    if (!hasDiscount || numericOldPrice == 0) return 0.0;
    return ((numericOldPrice! - numericPrice) / numericOldPrice!) * 100;
  }

  // Check if quantity is at maximum
  bool get isAtMaxQuantity {
    if (maxQuantity == null) return false;
    return quantity >= maxQuantity!;
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'oldPrice': oldPrice,
      'size': size,
      'colour': colour,
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
      'notes': notes,
      'maxQuantity': maxQuantity,
      'metadata': metadata,
    };
  }

  // Create from JSON for loading
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as String,
      oldPrice: json['oldPrice'] as String?,
      size: json['size'] as String,
      colour: json['colour'] as String,
      quantity: json['quantity'] as int,
      addedAt: json['addedAt'] != null 
          ? DateTime.parse(json['addedAt'] as String)
          : null,
      notes: json['notes'] as String?,
      maxQuantity: json['maxQuantity'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  // Create a copy with modified fields
  CartItem copyWith({
    String? id,
    String? productId,
    String? title,
    String? imageUrl,
    String? price,
    String? oldPrice,
    String? size,
    String? colour,
    int? quantity,
    DateTime? addedAt,
    String? notes,
    int? maxQuantity,
    Map<String, dynamic>? metadata,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      size: size ?? this.size,
      colour: colour ?? this.colour,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
      notes: notes ?? this.notes,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      metadata: metadata ?? this.metadata,
    );
  }
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
        i.title == item.title &&
        i.size == item.size &&
        i.colour == item.colour);
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
