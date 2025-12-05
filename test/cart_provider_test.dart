// filepath: test/cart_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/cart_provider.dart';
import 'package:union_shop/models/cart_variant.dart';

void main() {
  group('CartProvider Tests', () {
    late CartProvider cart;

    setUp(() {
      cart = CartProvider();
    });

    test('Should initialize with empty cart', () {
      expect(cart.items, isEmpty);
      expect(cart.itemCount, 0);
      expect(cart.totalPrice, 0.0);
      expect(cart.isLoading, false);
    });

    test('Should add item to cart', () {
      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 1,
        variant: CartVariant(size: 'M', colour: 'Black'),
      );

      expect(cart.items.length, 1);
      expect(cart.itemCount, 1);
      expect(cart.items.first.title, 'Test Product');
      expect(cart.items.first.quantity, 1);
    });

    test('Should update quantity when adding same item', () {
      final variant = CartVariant(size: 'M', colour: 'Black');
      
      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 1,
        variant: variant,
      );

      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 2,
        variant: variant,
      );

      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 3);
    });

    test('Should add separate items for different variants', () {
      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 1,
        variant: CartVariant(size: 'M', colour: 'Black'),
      );

      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 1,
        variant: CartVariant(size: 'L', colour: 'White'),
      );

      expect(cart.items.length, 2);
    });

    test('Should update quantity', () {
      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 1,
        variant: CartVariant(size: 'M', colour: 'Black'),
      );

      cart.updateQuantity(0, 5);
      expect(cart.items.first.quantity, 5);
    });

    test('Should remove item', () {
      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 1,
        variant: CartVariant(size: 'M', colour: 'Black'),
      );

      expect(cart.items.length, 1);
      cart.removeItem(0);
      expect(cart.items, isEmpty);
    });

    test('Should update variant', () {
      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 1,
        variant: CartVariant(size: 'M', colour: 'Black'),
      );

      final newVariant = CartVariant(size: 'L', colour: 'White');
      cart.updateVariant(0, newVariant);

      expect(cart.items.first.variant.size, 'L');
      expect(cart.items.first.variant.colour, 'White');
    });

    test('Should calculate total price correctly', () {
      cart.addItem(
        productId: 'test-1',
        name: 'Product 1',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 2,
        variant: CartVariant(size: 'M', colour: 'Black'),
      );

      cart.addItem(
        productId: 'test-2',
        name: 'Product 2',
        image: 'test.jpg',
        price: '£15.50',
        quantity: 1,
        variant: CartVariant(size: 'L', colour: 'White'),
      );

      expect(cart.totalPrice, 35.50);
    });

    test('Should clear cart', () {
      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 1,
        variant: CartVariant(size: 'M', colour: 'Black'),
      );

      expect(cart.items.length, 1);
      cart.clearCart();
      expect(cart.items, isEmpty);
    });

    test('Should handle price with old price', () {
      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        oldPrice: '£20.00',
        quantity: 1,
        variant: CartVariant(size: 'M', colour: 'Black'),
      );

      expect(cart.items.first.price, '£10.00');
      expect(cart.items.first.oldPrice, '£20.00');
    });

    test('Should calculate item count correctly', () {
      cart.addItem(
        productId: 'test-1',
        name: 'Product 1',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 3,
        variant: CartVariant(size: 'M', colour: 'Black'),
      );

      cart.addItem(
        productId: 'test-2',
        name: 'Product 2',
        image: 'test.jpg',
        price: '£15.00',
        quantity: 2,
        variant: CartVariant(size: 'L', colour: 'White'),
      );

      expect(cart.itemCount, 5);
    });
  });
}
