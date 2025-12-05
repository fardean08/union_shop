import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'services/cart_storage.dart';
import 'models/cart_variant.dart';

class CartItem {
  final String id;
  final String? productId;
  final String title;
  final String imageUrl;
  final String price;
  final String? oldPrice;
  final String size;
  final String colour;
  int quantity;
  final DateTime addedAt;
  String? notes;
  final int? maxQuantity;
  final Map<String, dynamic>? metadata;
  
  // Variant tracking
  late final CartVariant variant;

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
    CartVariant? variant,
  })  : id = id ?? const Uuid().v4(),
        addedAt = addedAt ?? DateTime.now() {
    // Initialize variant
    this.variant = variant ?? CartVariant(
      size: size,
      colour: colour,
      additionalAttributes: metadata != null 
        ? Map<String, String>.from(metadata)
        : null,
    );
  }

  double get numericPrice {
    final priceStr = price.replaceAll('£', '').replaceAll(',', '');
    return double.tryParse(priceStr) ?? 0.0;
  }

  double? get numericOldPrice {
    if (oldPrice == null) return null;
    final priceStr = oldPrice!.replaceAll('£', '').replaceAll(',', '');
    return double.tryParse(priceStr);
  }

  double get totalPrice => numericPrice * quantity;

  bool get hasDiscount => oldPrice != null && numericOldPrice != null;

  double get discountAmount {
    if (!hasDiscount) return 0.0;
    return (numericOldPrice! - numericPrice) * quantity;
  }

  double get discountPercentage {
    if (!hasDiscount || numericOldPrice == 0) return 0.0;
    return ((numericOldPrice! - numericPrice) / numericOldPrice!) * 100;
  }

  bool get isAtMaxQuantity {
    if (maxQuantity == null) return false;
    return quantity >= maxQuantity!;
  }

  // Check if this item matches another based on product and variant
  bool matchesProduct(CartItem other) {
    return productId == other.productId && 
           title == other.title &&
           variant.matches(other.variant);
  }

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
      'variant': variant.toJson(),
    };
  }

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
      variant: json['variant'] != null
          ? CartVariant.fromJson(json['variant'] as Map<String, dynamic>)
          : null,
    );
  }

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
    CartVariant? variant,
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
      variant: variant ?? this.variant,
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

  double get totalDiscount {
    return _items.fold(0.0, (sum, item) => sum + item.discountAmount);
  }

  int get uniqueItemCount => _items.length;

  Future<void> loadCart() async {
    if (_isLoaded) return;
    
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

  Future<void> _saveCart() async {
    try {
      await CartStorage.saveCartWithTimestamp(_items);
    } catch (e) {
      print('Error saving cart: $e');
    }
  }

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((i) => i.matchesProduct(item));
    
    if (existingIndex >= 0) {
      final existingItem = _items[existingIndex];
      final newQuantity = existingItem.quantity + item.quantity;
      
      if (existingItem.maxQuantity != null && 
          newQuantity > existingItem.maxQuantity!) {
        _items[existingIndex] = existingItem.copyWith(
          quantity: existingItem.maxQuantity,
        );
      } else {
        _items[existingIndex] = existingItem.copyWith(
          quantity: newQuantity,
        );
      }
    } else {
      _items.add(item);
    }
    notifyListeners();
    _saveCart();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
      _saveCart();
    }
  }

  void removeItemById(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
    _saveCart();
  }

  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length) {
      if (quantity > 0) {
        final item = _items[index];
        
        if (item.maxQuantity != null && quantity > item.maxQuantity!) {
          _items[index] = item.copyWith(quantity: item.maxQuantity);
        } else {
          _items[index] = item.copyWith(quantity: quantity);
        }
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
      _saveCart();
    }
  }

  void updateQuantityById(String id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      updateQuantity(index, quantity);
    }
  }

  void updateItemNotes(int index, String notes) {
    if (index >= 0 && index < _items.length) {
      _items[index].notes = notes;
      notifyListeners();
      _saveCart();
    }
  }

  void updateItemNotesById(String id, String notes) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      updateItemNotes(index, notes);
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
    _saveCart();
  }

  CartItem? getItemById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  bool get hasDiscountedItems {
    return _items.any((item) => item.hasDiscount);
  }

  int get itemsAtMaxCount {
    return _items.where((item) => item.isAtMaxQuantity).length;
  }

  // Get items grouped by product ID
  Map<String?, List<CartItem>> getItemsByProduct() {
    final grouped = <String?, List<CartItem>>{};
    for (var item in _items) {
      grouped.putIfAbsent(item.productId, () => []).add(item);
    }
    return grouped;
  }

  // Get all unique variants for a product
  List<CartVariant> getVariantsForProduct(String? productId) {
    return _items
        .where((item) => item.productId == productId)
        .map((item) => item.variant)
        .toSet()
        .toList();
  }

  // Update variant for an item
  void updateItemVariant(int index, String size, String colour) {
    if (index >= 0 && index < _items.length) {
      final item = _items[index];
      final newVariant = CartVariant(
        size: size,
        colour: colour,
        additionalAttributes: item.variant.additionalAttributes,
      );
      
      _items[index] = item.copyWith(
        size: size,
        colour: colour,
        variant: newVariant,
      );
      notifyListeners();
      _saveCart();
    }
  }

  Future<String?> exportCart() async {
    return await CartStorage.exportCart();
  }

  Future<bool> importCart(String jsonString) async {
    final success = await CartStorage.importCart(jsonString);
    if (success) {
      await loadCart();
    }
    return success;
  }

  Future<bool> validateCart() async {
    return await CartStorage.validateCart();
  }

  Future<int> cleanupCart() async {
    final removedCount = await CartStorage.cleanupCart();
    if (removedCount > 0) {
      await loadCart();
    }
    return removedCount;
  }

  Future<bool> backupCart() async {
    return await CartStorage.backupCart();
  }

  Future<bool> restoreFromBackup() async {
    final success = await CartStorage.restoreFromBackup();
    if (success) {
      await loadCart();
    }
    return success;
  }

  Future<bool> hasBackup() async {
    return await CartStorage.hasBackup();
  }

  Future<DateTime?> getBackupTime() async {
    return await CartStorage.getBackupTime();
  }

  Future<bool> mergeItems(List<CartItem> newItems) async {
    final success = await CartStorage.mergeCart(newItems);
    if (success) {
      await loadCart();
    }
    return success;
  }

  Future<int> getStorageSize() async {
    return await CartStorage.getCartSize();
  }

  Future<void> reloadCart() async {
    _isLoaded = false;
    await loadCart();
  }
}
