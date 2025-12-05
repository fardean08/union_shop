import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/cart_provider.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Product Page Tests', () {
    Widget createTestWidget({Product? product}) {
      return ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: MaterialApp(
          home: ProductPage(product: product),
        ),
      );
    }

    testWidgets('should display product page with default product', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that basic UI elements are present
      expect(find.text('UNION Shop Product'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('Tax included.'), findsOneWidget);
    });

    testWidgets('should display product details with custom product', (tester) async {
      final testProduct = Product(
        id: 'test-1',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 25.00,
        sizes: ['S', 'M', 'L'],
        colors: ['Black', 'White'],
      );

      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£25.00'), findsOneWidget);
    });

    testWidgets('should have size and color dropdowns', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Size'), findsWidgets);
      expect(find.text('Color'), findsWidgets);
      expect(find.byType(DropdownButton<String>), findsWidgets);
    });

    testWidgets('should have add to cart button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Add to cart'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('should display cart icon', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    });
  });
}
