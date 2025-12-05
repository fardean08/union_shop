import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../cart_provider.dart';

/// Service for persisting cart data to local storage
class CartStorage {
  static const String _cartKey = 'shopping_cart';
  static const String _backupKey = 'shopping_cart_backup';
  static const String _versionKey = 'cart_version';
  static const int _currentVersion = 1;

  /// Save cart items to SharedPreferences
  static Future<bool> saveCart(List<CartItem> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = {
        'version': _currentVersion,
        'items': items.map((item) => item.toJson()).toList(),
        'lastSaved': DateTime.now().toIso8601String(),
      };
      return await prefs.setString(_cartKey, jsonEncode(cartData));
    } catch (e) {
      print('Error saving cart: $e');
      return false;
    }
  }

  /// Load cart items from SharedPreferences
  static Future<List<CartItem>> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartString = prefs.getString(_cartKey);
      
      if (cartString == null) {
        return [];
      }

      final cartData = jsonDecode(cartString) as Map<String, dynamic>;
      final version = cartData['version'] as int? ?? 1;
      
      // Handle version migrations if needed
      if (version != _currentVersion) {
        // Future: Add migration logic here
      }

      final itemsJson = cartData['items'] as List;
      return itemsJson.map((json) => CartItem.fromJson(json)).toList();
    } catch (e) {
      print('Error loading cart: $e');
      return [];
    }
  }

  /// Clear cart from storage
  static Future<bool> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_cartKey);
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
      print('Error checking cart: $e');
      return false;
    }
  }

  /// Get quick count of cart items without full deserialization
  static Future<int> getCartItemCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartString = prefs.getString(_cartKey);
      
      if (cartString == null) return 0;

      final cartData = jsonDecode(cartString) as Map<String, dynamic>;
      final items = cartData['items'] as List;
      return items.length;
    } catch (e) {
      print('Error getting cart count: $e');
      return 0;
    }
  }

  /// Get the last save timestamp
  static Future<DateTime?> getLastSaveTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartString = prefs.getString(_cartKey);
      
      if (cartString == null) return null;

      final cartData = jsonDecode(cartString) as Map<String, dynamic>;
      final lastSaved = cartData['lastSaved'] as String?;
      
      return lastSaved != null ? DateTime.parse(lastSaved) : null;
    } catch (e) {
      print('Error getting last save time: $e');
      return null;
    }
  }

  /// Export cart as JSON string (for sharing or backup)
  static Future<String?> exportCart() async {
    try {
      final items = await loadCart();
      return jsonEncode({
        'version': _currentVersion,
        'items': items.map((item) => item.toJson()).toList(),
        'exportedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error exporting cart: $e');
      return null;
    }
  }

  /// Import cart from JSON string
  static Future<List<CartItem>?> importCart(String jsonString) async {
    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      final itemsJson = data['items'] as List;
      return itemsJson.map((json) => CartItem.fromJson(json)).toList();
    } catch (e) {
      print('Error importing cart: $e');
      return null;
    }
  }

  /// Validate cart data integrity
  static Future<bool> validateCart() async {
    try {
      final items = await loadCart();
      
      // Check for duplicate IDs
      final ids = items.map((item) => item.id).toSet();
      if (ids.length != items.length) {
        return false;
      }

      // Check for valid quantities and prices
      for (final item in items) {
        if (item.quantity <= 0) return false;
        if (item.numericPrice < 0) return false;
        if (item.maxQuantity != null && item.quantity > item.maxQuantity!) {
          return false;
        }
      }

      return true;
    } catch (e) {
      print('Error validating cart: $e');
      return false;
    }
  }

  /// Clean up invalid cart items
  static Future<List<CartItem>> cleanupCart() async {
    try {
      final items = await loadCart();
      final validItems = items.where((item) {
        return item.quantity > 0 && 
               item.numericPrice >= 0 &&
               (item.maxQuantity == null || item.quantity <= item.maxQuantity!);
      }).toList();

      // Remove duplicate IDs (keep first occurrence)
      final seenIds = <String>{};
      final uniqueItems = validItems.where((item) {
        if (seenIds.contains(item.id)) {
          return false;
        }
        seenIds.add(item.id);
        return true;
      }).toList();

      if (uniqueItems.length != items.length) {
        await saveCart(uniqueItems);
      }

      return uniqueItems;
    } catch (e) {
      print('Error cleaning cart: $e');
      return [];
    }
  }

  /// Create a backup of the current cart
  static Future<bool> backupCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartString = prefs.getString(_cartKey);
      
      if (cartString == null) return false;

      return await prefs.setString(_backupKey, cartString);
    } catch (e) {
      print('Error backing up cart: $e');
      return false;
    }
  }

  /// Restore cart from backup
  static Future<bool> restoreFromBackup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final backupString = prefs.getString(_backupKey);
      
      if (backupString == null) return false;

      return await prefs.setString(_cartKey, backupString);
    } catch (e) {
      print('Error restoring from backup: $e');
      return false;
    }
  }

  /// Merge imported cart with existing cart
  static Future<List<CartItem>> mergeCart(List<CartItem> importedItems) async {
    try {
      final existingItems = await loadCart();
      final mergedItems = <String, CartItem>{};

      // Add existing items
      for (final item in existingItems) {
        mergedItems[item.id] = item;
      }

      // Merge imported items
      for (final item in importedItems) {
        if (mergedItems.containsKey(item.id)) {
          // If same ID exists, update quantity
          final existing = mergedItems[item.id]!;
          mergedItems[item.id] = existing.copyWith(
            quantity: existing.quantity + item.quantity,
          );
        } else {
          mergedItems[item.id] = item;
        }
      }

      return mergedItems.values.toList();
    } catch (e) {
      print('Error merging cart: $e');
      return [];
    }
  }

  /// Get storage size in bytes
  static Future<int> getStorageSize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartString = prefs.getString(_cartKey);
      
      if (cartString == null) return 0;

      return cartString.length;
    } catch (e) {
      print('Error getting storage size: $e');
      return 0;
    }
  }

  /// Force reload cart from storage
  static Future<List<CartItem>> forceReload() async {
    return await loadCart();
  }
}
