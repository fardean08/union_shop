import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../cart_provider.dart';

class CartStorage {
  static const String _cartKey = 'shopping_cart';
  static const String _cartVersionKey = 'cart_version';
  static const int _currentVersion = 1;

  /// Save cart items to local storage
  static Future<bool> saveCart(List<CartItem> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Convert items to JSON
      final itemsJson = items.map((item) => item.toJson()).toList();
      final jsonString = jsonEncode(itemsJson);
      
      // Save to SharedPreferences
      await prefs.setString(_cartKey, jsonString);
      await prefs.setInt(_cartVersionKey, _currentVersion);
      
      return true;
    } catch (e) {
      print('Error saving cart: $e');
      return false;
    }
  }

  /// Load cart items from local storage
  static Future<List<CartItem>> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check version compatibility
      final version = prefs.getInt(_cartVersionKey) ?? 0;
      if (version != _currentVersion) {
        // Version mismatch, clear old cart
        await clearCart();
        return [];
      }
      
      // Get cart data
      final jsonString = prefs.getString(_cartKey);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }
      
      // Parse JSON
      final List<dynamic> itemsJson = jsonDecode(jsonString);
      final items = itemsJson
          .map((json) => CartItem.fromJson(json as Map<String, dynamic>))
          .toList();
      
      return items;
    } catch (e) {
      print('Error loading cart: $e');
      return [];
    }
  }

  /// Clear all cart data from storage
  static Future<bool> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cartKey);
      await prefs.remove(_cartVersionKey);
      return true;
    } catch (e) {
      print('Error clearing cart: $e');
      return false;
    }
  }

  /// Check if cart exists in storage
  static Future<bool> hasCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_cartKey);
    } catch (e) {
      return false;
    }
  }

  /// Get cart item count without loading full cart
  static Future<int> getCartItemCount() async {
    try {
      final items = await loadCart();
      return items.fold(0, (sum, item) => sum + item.quantity);
    } catch (e) {
      return 0;
    }
  }

  /// Get last save timestamp
  static Future<DateTime?> getLastSaveTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt('cart_last_save');
      if (timestamp != null) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Update last save timestamp
  static Future<void> _updateLastSaveTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('cart_last_save', DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('Error updating save time: $e');
    }
  }

  /// Save cart with timestamp
  static Future<bool> saveCartWithTimestamp(List<CartItem> items) async {
    final success = await saveCart(items);
    if (success) {
      await _updateLastSaveTime();
    }
    return success;
  }
}
