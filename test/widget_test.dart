// filepath: test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/cart_provider.dart';

void main() {
  group('App Initialization Tests', () {
    testWidgets('App should launch successfully', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Should initialize with CartProvider', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      
      final context = tester.element(find.byType(MaterialApp));
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      
      expect(cartProvider, isNotNull);
      expect(cartProvider.items, isEmpty);
      expect(cartProvider.itemCount, 0);
    });

    testWidgets('Should display home screen by default', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });

  group('Responsive Helper Tests', () {
    testWidgets('Should detect mobile screen size', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      
      // On mobile, hamburger menu should be visible
      expect(find.byIcon(Icons.menu), findsWidgets);
    });

    testWidgets('Should detect desktop screen size', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      
      // On desktop, full navigation should be visible
      expect(find.text('Home'), findsWidgets);
      expect(find.text('Shop'), findsWidgets);
    });
  });

  group('Theme Tests', () {
    testWidgets('Should use correct primary color', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.primaryColor, const Color(0xFF4d2963));
    });    testWidgets('Should use correct font family', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.textTheme.bodyLarge?.fontFamily, 'Roboto');
    });
  });
}
