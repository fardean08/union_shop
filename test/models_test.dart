// filepath: test/models_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart_variant.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('CartVariant Tests', () {
    test('Should create CartVariant with size and colour', () {
      final variant = CartVariant(size: 'M', colour: 'Black');
      
      expect(variant.size, 'M');
      expect(variant.colour, 'Black');
    });

    test('Should compare CartVariants correctly', () {
      final variant1 = CartVariant(size: 'M', colour: 'Black');
      final variant2 = CartVariant(size: 'M', colour: 'Black');
      final variant3 = CartVariant(size: 'L', colour: 'White');
      
      expect(variant1 == variant2, true);
      expect(variant1 == variant3, false);
    });

    test('Should have correct hashCode', () {
      final variant1 = CartVariant(size: 'M', colour: 'Black');
      final variant2 = CartVariant(size: 'M', colour: 'Black');
      
      expect(variant1.hashCode, variant2.hashCode);
    });

    test('Should convert to JSON', () {
      final variant = CartVariant(size: 'M', colour: 'Black');
      final json = variant.toJson();
      
      expect(json['size'], 'M');
      expect(json['colour'], 'Black');
    });

    test('Should create from JSON', () {
      final json = {'size': 'L', 'colour': 'White'};
      final variant = CartVariant.fromJson(json);
      
      expect(variant.size, 'L');
      expect(variant.colour, 'White');
    });
  });

  group('Product Tests', () {
    test('Should create Product with all fields', () {
      final product = Product(
        id: 'test-1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        oldPrice: 15.0,
        sizes: ['S', 'M', 'L'],
        colors: ['Black', 'White'],
      );

      expect(product.id, 'test-1');
      expect(product.title, 'Test Product');
      expect(product.imageUrl, 'https://example.com/image.jpg');
      expect(product.price, 10.0);
      expect(product.oldPrice, 15.0);
      expect(product.sizes, ['S', 'M', 'L']);
      expect(product.colors, ['Black', 'White']);
    });

    test('Should format price string correctly', () {
      final product = Product(
        id: 'test-1',
        title: 'Test Product',
        imageUrl: 'test.jpg',
        price: 10.0,
        sizes: ['M'],
        colors: ['Black'],
      );

      expect(product.priceString, '£10.00');
    });

    test('Should format old price string correctly', () {
      final product = Product(
        id: 'test-1',
        title: 'Test Product',
        imageUrl: 'test.jpg',
        price: 10.0,
        oldPrice: 15.50,
        sizes: ['M'],
        colors: ['Black'],
      );

      expect(product.oldPriceString, '£15.50');
    });

    test('Should handle null old price', () {
      final product = Product(
        id: 'test-1',
        title: 'Test Product',
        imageUrl: 'test.jpg',
        price: 10.0,
        sizes: ['M'],
        colors: ['Black'],
      );

      expect(product.oldPrice, null);
      expect(product.oldPriceString, null);
    });

    test('Should have default sizes and colors', () {
      final product = Product(
        id: 'test-1',
        title: 'Test Product',
        imageUrl: 'test.jpg',
        price: 10.0,
      );

      expect(product.sizes, ['S', 'M', 'L', 'XL']);
      expect(product.colors, ['Black', 'White', 'Navy']);
    });

    test('Should create from JSON', () {
      final json = {
        'id': 'test-1',
        'title': 'Test Product',
        'imageUrl': 'test.jpg',
        'price': 10.0,
        'oldPrice': 15.0,
        'sizes': ['S', 'M'],
        'colors': ['Black'],
      };

      final product = Product.fromJson(json);

      expect(product.id, 'test-1');
      expect(product.title, 'Test Product');
      expect(product.price, 10.0);
      expect(product.oldPrice, 15.0);
    });

    test('Should convert to JSON', () {
      final product = Product(
        id: 'test-1',
        title: 'Test Product',
        imageUrl: 'test.jpg',
        price: 10.0,
        oldPrice: 15.0,
        sizes: ['M'],
        colors: ['Black'],
      );

      final json = product.toJson();

      expect(json['id'], 'test-1');
      expect(json['title'], 'Test Product');
      expect(json['price'], 10.0);
      expect(json['oldPrice'], 15.0);
    });
  });
}
