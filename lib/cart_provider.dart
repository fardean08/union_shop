import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'models/cart_variant.dart';
import 'services/cart_storage.dart';

/// Enhanced CartItem with unique ID, metadata, and variant tracking
class CartItem {
  final String id; // Unique identifier using UUID
  final String productId; // Product reference ID
  final String name;
  final String price;
  final String image;
  final int quantity;
  final DateTime addedAt;
  final String? notes;
  final int? maxQuantity;
  final Map<String, dynamic>? metadata;
  final CartVariant? variant; // Size, color, etc.

  CartItem({
    String? id,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
    DateTime? addedAt,
    this.notes,
    this.maxQuantity,
    this.metadata,
    this.variant,
  })  : id = id ?? const Uuid().v4(),
        addedAt = addedAt ?? DateTime.now();

  /// Get numeric price value
  double get numericPrice {
    final cleanPrice = price.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleanPrice) ?? 0.0;
  }

  /// Calculate total price for this item
  double get totalPrice => numericPrice * quantity;

  /// Check if item has a discount
  bool get hasDiscount {
    return metadata?['originalPrice'] != null;
  }

  /// Get discount amount if applicable
  double get discountAmount {
    if (!hasDiscount) return 0.0;
    final originalPrice = metadata!['originalPrice'] as double;
    return (originalPrice - numericPrice) * quantity;
  }

  /// Get discount percentage
  double get discountPercentage {
    if (!hasDiscount) return 0.0;
    final originalPrice = metadata!['originalPrice'] as double;
    return ((originalPrice - numericPrice) / originalPrice) * 100;
  }

  /// Check if at maximum quantity
  bool get isAtMaxQuantity {
    return maxQuantity != null && quantity >= maxQuantity!;
  }

  /// Check if this item matches a product with specific variant
  bool matchesProduct(String prodId, CartVariant? prodVariant) {
    if (productId != prodId) return false;
    
    // If no variants specified, match by product ID only
    if (variant == null && prodVariant == null) return true;
    
    // If one has variant and other doesn't, they don't match
    if (variant == null || prodVariant == null) return false;
    
    // Match by variant
    return variant!.matches(prodVariant);
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
      'notes': notes,
      'maxQuantity': maxQuantity,
      'metadata': metadata,
      'variant': variant?.toJson(),
    };
  }

  /// Create from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      productId: json['productId'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      image: json['image'] as String,
      quantity: json['quantity'] as int,
      addedAt: DateTime.parse(json['addedAt'] as String),
      notes: json['notes'] as String?,
      maxQuantity: json['maxQuantity'] as int?,
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'] as Map)
          : null,
      variant: json['variant'] != null
          ? CartVariant.fromJson(json['variant'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Create a copy with modified fields
  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    String? price,
    String? image,
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
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
      notes: notes ?? this.notes,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      metadata: metadata ?? this.metadata,
      variant: variant ?? this.variant,
    );
  }
}

/// Cart Provider with persistence and advanced operations
class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  bool _isLoading = false;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// Load cart from storage on initialization
  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      _items = await CartStorage.loadCart();
    } catch (e) {
      print('Error loading cart: $e');
      _items = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Save cart to storage
  Future<void> _saveCart() async {
    await CartStorage.saveCart(_items);
  }

  /// Add item to cart with smart duplicate detection
  void addItem({
    required String productId,
    required String name,
    required String price,
    required String image,
    int quantity = 1,
    String? notes,
    int? maxQuantity,
    Map<String, dynamic>? metadata,
    CartVariant? variant,
  }) {
    // Check if item with same product and variant already exists
    final existingIndex = _items.indexWhere(
      (item) => item.matchesProduct(productId, variant),
    );

    if (existingIndex >= 0) {
      // Update quantity of existing item
      final existing = _items[existingIndex];
      final newQuantity = existing.quantity + quantity;
      
      // Check max quantity limit
      if (existing.maxQuantity != null && newQuantity > existing.maxQuantity!) {
        print('Cannot exceed maximum quantity of ${existing.maxQuantity}');
        return;
      }

      _items[existingIndex] = existing.copyWith(quantity: newQuantity);
    } else {
      // Add new item
      _items.add(CartItem(
        productId: productId,
        name: name,
        price: price,
        image: image,
        quantity: quantity,
        notes: notes,
        maxQuantity: maxQuantity,
        metadata: metadata,
        variant: variant,
      ));
    }

    _saveCart();
    notifyListeners();
  }

  /// Remove item from cart by index
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      _saveCart();
      notifyListeners();
    }
  }

  /// Remove item from cart by ID
  void removeItemById(String id) {
    _items.removeWhere((item) => item.id == id);
    _saveCart();
    notifyListeners();
  }

  /// Update item quantity
  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _items.length) {
      if (newQuantity <= 0) {
        removeItem(index);
        return;
      }

      final item = _items[index];
      
      // Check max quantity limit
      if (item.maxQuantity != null && newQuantity > item.maxQuantity!) {
        print('Cannot exceed maximum quantity of ${item.maxQuantity}');
        return;
      }

      _items[index] = item.copyWith(quantity: newQuantity);
      _saveCart();
      notifyListeners();
    }
  }

  /// Update item variant (size, color, etc.)
  void updateItemVariant(int index, String? size, String? colour) {
    if (index >= 0 && index < _items.length) {
      final item = _items[index];
      
      // Create new variant or update existing
      final newVariant = CartVariant(
        size: size ?? item.variant?.size ?? 'M',
        colour: colour ?? item.variant?.colour ?? 'Black',
        additionalAttributes: item.variant?.additionalAttributes,
      );

      _items[index] = item.copyWith(variant: newVariant);
      _saveCart();
      notifyListeners();
    }
  }

  /// Get all items for a specific product
  List<CartItem> getItemsByProduct(String productId) {
    return _items.where((item) => item.productId == productId).toList();
  }

  /// Get unique variants for a product
  List<CartVariant> getVariantsForProduct(String productId) {
    final productItems = getItemsByProduct(productId);
    final variants = <String, CartVariant>{};
    
    for (final item in productItems) {
      if (item.variant != null) {
        variants[item.variant!.variantKey] = item.variant!;
      }
    }
    
    return variants.values.toList();
  }

  /// Clear all items from cart
  void clearCart() {
    _items.clear();
    CartStorage.clearCart();
    notifyListeners();
  }

  /// Export cart as JSON string
  Future<String?> exportCart() async {
    return await CartStorage.exportCart();
  }

  /// Import cart from JSON string
  Future<bool> importCart(String jsonString) async {
    try {
      final importedItems = await CartStorage.importCart(jsonString);
      if (importedItems != null) {
        _items = importedItems;
        await _saveCart();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error importing cart: $e');
      return false;
    }
  }

  /// Merge imported cart with current cart
  Future<bool> mergeImportedCart(String jsonString) async {
    try {
      final importedItems = await CartStorage.importCart(jsonString);
      if (importedItems != null) {
        _items = await CartStorage.mergeCart(importedItems);
        await _saveCart();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error merging cart: $e');
      return false;
    }
  }

  /// Validate cart integrity
  Future<bool> validateCart() async {
    return await CartStorage.validateCart();
  }

  /// Clean up invalid items
  Future<void> cleanupCart() async {
    _items = await CartStorage.cleanupCart();
    notifyListeners();
  }

  /// Create backup
  Future<bool> backupCart() async {
    return await CartStorage.backupCart();
  }

  /// Restore from backup
  Future<bool> restoreFromBackup() async {
    final success = await CartStorage.restoreFromBackup();
    if (success) {
      await loadCart();
    }
    return success;
  }

  /// Get total discount amount
  double get totalDiscount {
    return _items.fold(0.0, (sum, item) => sum + item.discountAmount);
  }

  /// Get cart subtotal (before discounts)
  double get subtotal {
    return totalAmount + totalDiscount;
  }
}
