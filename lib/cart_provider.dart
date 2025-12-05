import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'services/cart_storage.dart';

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
  bool _isLoaded = false;

  List<CartItem> get items => _items;

  bool get isLoaded => _isLoaded;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Get total discount amount across all items
  double get totalDiscount {
    return _items.fold(0.0, (sum, item) => sum + item.discountAmount);
  }

  // Get total items (unique products, not quantity)
  int get uniqueItemCount => _items.length;

  /// Initialize and load cart from storage
  Future<void> loadCart() async {
    if (_isLoaded) return; // Already loaded
    
    try {
      final savedItems = await CartStorage.loadCart();
      _items.clear();
      _items.addAll(savedItems);
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      print('Error loading cart: $e');
      _isLoaded = true;
      notifyListeners();
    }
  }

  /// Save cart to storage
  Future<void> _saveCart() async {
    try {
      await CartStorage.saveCartWithTimestamp(_items);
    } catch (e) {
      print('Error saving cart: $e');
    }
  }

  void addItem(CartItem item) {
    // Check if similar item exists (same product, size, color)
    final existingIndex = _items.indexWhere((i) =>
        i.productId == item.productId &&
        i.title == item.title &&
        i.size == item.size &&
        i.colour == item.colour);
    
    if (existingIndex >= 0) {
      // Item exists, increase quantity
      final existingItem = _items[existingIndex];
      final newQuantity = existingItem.quantity + item.quantity;
      
      // Check max quantity limit
      if (existingItem.maxQuantity != null && 
          newQuantity > existingItem.maxQuantity!) {
        // Don't exceed max quantity
        _items[existingIndex] = existingItem.copyWith(
          quantity: existingItem.maxQuantity,
        );
      } else {
        _items[existingIndex] = existingItem.copyWith(
          quantity: newQuantity,
        );
      }
    } else {
      // New item, add to cart
      _items.add(item);
    }
    notifyListeners();
    _saveCart(); // Save after adding
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
      _saveCart(); // Save after removing
    }
  }

  // Remove item by ID
  void removeItemById(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
    _saveCart(); // Save after removing
  }

  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length) {
      if (quantity > 0) {
        final item = _items[index];
        
        // Check max quantity limit
        if (item.maxQuantity != null && quantity > item.maxQuantity!) {
          _items[index] = item.copyWith(quantity: item.maxQuantity);
        } else {
          _items[index] = item.copyWith(quantity: quantity);
        }
      } else {
        // Quantity is 0 or negative, remove item
        _items.removeAt(index);
      }
      notifyListeners();
      _saveCart(); // Save after updating
    }
  }

  // Update quantity by item ID
  void updateQuantityById(String id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      updateQuantity(index, quantity);
    }
  }

  // Update item notes
  void updateItemNotes(int index, String notes) {
    if (index >= 0 && index < _items.length) {
      _items[index].notes = notes;
      notifyListeners();
      _saveCart(); // Save after updating notes
    }
  }

  // Update item notes by ID
  void updateItemNotesById(String id, String notes) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      updateItemNotes(index, notes);
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
    _saveCart(); // Save after clearing
  }

  // Get item by ID
  CartItem? getItemById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  // Check if cart has items with discounts
  bool get hasDiscountedItems {
    return _items.any((item) => item.hasDiscount);
  }

  // Get count of items at max quantity
  int get itemsAtMaxCount {
    return _items.where((item) => item.isAtMaxQuantity).length;
  }
}
