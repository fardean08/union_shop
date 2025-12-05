// filepath: test/integration_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/cart_provider.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart_variant.dart';
import 'package:union_shop/product_page.dart';

void main() {
  group('Integration Tests', () {
    testWidgets('Complete shopping flow - add to cart and checkout', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Verify we're on home page
      expect(find.byType(HomeScreen), findsOneWidget);

      // Navigate to a product (click first "Quick View" button)
      final quickViewButtons = find.text('Quick View');
      if (quickViewButtons.evaluate().isNotEmpty) {
        await tester.tap(quickViewButtons.first);
        await tester.pumpAndSettle();

        // Should be on product page
        expect(find.text('Add to cart'), findsOneWidget);

        // Add product to cart
        final addToCartButton = find.text('Add to cart');
        await tester.tap(addToCartButton);
        await tester.pumpAndSettle();

        // Should show confirmation snackbar
        expect(find.text('Added to cart!'), findsOneWidget);

        // Go to cart
        final cartIcon = find.byIcon(Icons.shopping_bag_outlined).first;
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Should be on cart page with item
        expect(find.text('Your cart'), findsOneWidget);
        expect(find.text('Checkout'), findsOneWidget);
      }
    });

    testWidgets('Product filtering and sorting flow', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Set to desktop size
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to sale page
      final saleLink = find.text('SALE!').first;
      await tester.tap(saleLink);
      await tester.pumpAndSettle();

      // Should be on sale page
      expect(find.text('SALE'), findsOneWidget);

      // Try to change sort option
      final sortDropdown = find.byType(DropdownButton<String>);
      if (sortDropdown.evaluate().isNotEmpty) {
        await tester.tap(sortDropdown.first);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Cart quantity update flow', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(MaterialApp));
      final cart = Provider.of<CartProvider>(context, listen: false);

      // Add item directly to cart
      cart.addItem(
        productId: 'test-1',
        name: 'Test Product',
        image: 'test.jpg',
        price: '£10.00',
        quantity: 1,
        variant: const CartVariant(size: 'M', colour: 'Black'),
      );

      await tester.pumpAndSettle();

      // Navigate to cart
      final cartIcon = find.byIcon(Icons.shopping_bag_outlined).first;
      await tester.tap(cartIcon);
      await tester.pumpAndSettle();

      // Cart should have the item
      expect(cart.itemCount, 1);
      expect(cart.items.first.title, 'Test Product');

      // Find quantity buttons
      final plusButtons = find.byIcon(Icons.add);
      if (plusButtons.evaluate().isNotEmpty) {
        await tester.tap(plusButtons.first);
        await tester.pumpAndSettle();

        // Quantity should increase
        expect(cart.items.first.quantity, 2);
      }
    });

    testWidgets('Responsive layout switch', (WidgetTester tester) async {
      // Start with desktop size
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Should show desktop navigation
      expect(find.text('Home'), findsWidgets);
      expect(find.text('Shop'), findsWidgets);

      // Switch to mobile size
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Should show hamburger menu
      expect(find.byIcon(Icons.menu), findsWidgets);

      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    });

    testWidgets('Search flow', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Find and tap search icon
      final searchIcons = find.byIcon(Icons.search);
      if (searchIcons.evaluate().isNotEmpty) {
        await tester.tap(searchIcons.first);
        await tester.pumpAndSettle();

        // Should navigate to search page
        expect(find.text('Popular Searches'), findsOneWidget);

        // Type in search field
        final searchField = find.byType(TextField).first;
        await tester.enterText(searchField, 'hoodie');
        await tester.pumpAndSettle();

        // Results should appear
        // (In a real app, this would show actual search results)
      }
    });

    testWidgets('Mobile drawer navigation flow', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Open drawer
      final hamburger = find.byIcon(Icons.menu).first;
      await tester.tap(hamburger);
      await tester.pumpAndSettle();

      // Drawer should be open
      expect(find.text('NAVIGATION'), findsOneWidget);

      // Navigate to About
      final aboutLink = find.text('About').first;
      await tester.tap(aboutLink);
      await tester.pumpAndSettle();

      // Should be on about page
      expect(find.text('About Us'), findsWidgets);

      // Open drawer again
      final hamburger2 = find.byIcon(Icons.menu).first;
      await tester.tap(hamburger2);
      await tester.pumpAndSettle();

      // Navigate to Print Shack
      final printShackLink = find.text('Print Shack').first;
      await tester.tap(printShackLink);
      await tester.pumpAndSettle();

      // Should be on print shack page
      expect(find.text('DESIGN YOUR OWN'), findsOneWidget);
    });

    testWidgets('Cart persistence test', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(MaterialApp));
      final cart = Provider.of<CartProvider>(context, listen: false);

      // Add multiple items
      cart.addItem(
        productId: 'test-1',
        name: 'Product 1',
        image: 'test1.jpg',
        price: '£10.00',
        quantity: 2,
        variant: const CartVariant(size: 'M', colour: 'Black'),
      );

      cart.addItem(
        productId: 'test-2',
        name: 'Product 2',
        image: 'test2.jpg',
        price: '£15.00',
        quantity: 1,
        variant: const CartVariant(size: 'L', colour: 'White'),
      );

      await tester.pumpAndSettle();

      // Verify cart state
      expect(cart.itemCount, 3); // 2 + 1
      expect(cart.items.length, 2);
      expect(cart.totalPrice, 35.0); // (10 * 2) + (15 * 1)

      // Navigate away and back
      final aboutLink = find.text('About').first;
      await tester.tap(aboutLink);
      await tester.pumpAndSettle();

      // Go to cart
      final cartIcon = find.byIcon(Icons.shopping_bag_outlined).first;
      await tester.tap(cartIcon);
      await tester.pumpAndSettle();

      // Cart should still have items
      final cartAfterNav = Provider.of<CartProvider>(
        tester.element(find.byType(MaterialApp)),
        listen: false,
      );
      expect(cartAfterNav.itemCount, 3);
      expect(cartAfterNav.items.length, 2);
    });

    testWidgets('Product variant selection flow', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ProductPage(
          product: Product(
            id: 'test-1',
            title: 'Test Product',
            imageUrl: 'test.jpg',
            price: 10.0,
            sizes: ['S', 'M', 'L', 'XL'],
            colors: ['Black', 'White', 'Navy'],
          ),
        ),
      ));
      await tester.pumpAndSettle();

      // Should display product
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);

      // Size and color dropdowns should be present
      expect(find.text('Size'), findsWidgets);
      expect(find.text('Color'), findsWidgets);

      // Try to select a size
      final sizeDropdown = find.byType(DropdownButton<String>).first;
      await tester.tap(sizeDropdown);
      await tester.pumpAndSettle();

      // Should show size options
      expect(find.text('XL').hitTestable(), findsWidgets);
    });
  });
}
