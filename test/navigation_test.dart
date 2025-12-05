// filepath: test/navigation_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Navigation Tests', () {
    testWidgets('Should navigate to collections page', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Find and tap "Shop" link in desktop view
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final shopLink = find.text('Shop').first;
      await tester.tap(shopLink);
      await tester.pumpAndSettle();

      expect(find.text('Collections'), findsWidgets);
    });

    testWidgets('Should navigate to about page', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final aboutLink = find.text('About').first;
      await tester.tap(aboutLink);
      await tester.pumpAndSettle();

      expect(find.text('About Us'), findsWidgets);
    });

    testWidgets('Should navigate to cart page', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final cartIcon = find.byIcon(Icons.shopping_bag_outlined).first;
      await tester.tap(cartIcon);
      await tester.pumpAndSettle();

      expect(find.text('Your cart'), findsWidgets);
    });

    testWidgets('Should navigate back from cart page', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Go to cart
      final cartIcon = find.byIcon(Icons.shopping_bag_outlined).first;
      await tester.tap(cartIcon);
      await tester.pumpAndSettle();

      // Go back
      final backButton = find.byIcon(Icons.arrow_back);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Mobile drawer should open on hamburger tap', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final hamburger = find.byIcon(Icons.menu).first;
      await tester.tap(hamburger);
      await tester.pumpAndSettle();

      // Drawer should be visible
      expect(find.text('NAVIGATION'), findsOneWidget);
    });

    testWidgets('Should navigate from mobile drawer', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Open drawer
      final hamburger = find.byIcon(Icons.menu).first;
      await tester.tap(hamburger);
      await tester.pumpAndSettle();

      // Tap "Shop" in drawer
      final shopInDrawer = find.text('Shop').first;
      await tester.tap(shopInDrawer);
      await tester.pumpAndSettle();

      // Should navigate to collections
      expect(find.text('Collections'), findsWidgets);
    });

    testWidgets('Should navigate to sale page', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final saleLink = find.text('SALE!').first;
      await tester.tap(saleLink);
      await tester.pumpAndSettle();

      expect(find.text('SALE'), findsWidgets);
    });

    testWidgets('Should navigate to print shack page', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final printShackLink = find.text('Print Shack').first;
      await tester.tap(printShackLink);
      await tester.pumpAndSettle();

      expect(find.text('DESIGN YOUR OWN'), findsWidgets);
    });
  });

  group('Route Tests', () {
    testWidgets('Should handle unknown routes', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      
      final context = tester.element(find.byType(MaterialApp));
      final navigator = Navigator.of(context);
      
      // Try to navigate to unknown route
      navigator.pushNamed('/unknown-route');
      await tester.pumpAndSettle();
      
      // Should stay on home or show error
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
