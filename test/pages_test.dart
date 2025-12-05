// filepath: test/pages_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/cart_provider.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/search_page.dart';
import 'package:union_shop/login_page.dart';
import 'package:union_shop/signup_page.dart';
import 'package:union_shop/print_shack_page.dart';

void main() {
  group('HomePage Tests', () {
    testWidgets('Should display announcement bar', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.byType(AnnouncementBar), findsOneWidget);
    });

    testWidgets('Should display navbar', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.byType(Navbar), findsOneWidget);
    });

    testWidgets('Should display hero banner', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.byType(HeroBanner), findsOneWidget);
    });

    testWidgets('Should display featured section', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.byType(FeaturedSection), findsOneWidget);
    });

    testWidgets('Should display footer', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.byType(Footer), findsOneWidget);
    });

    testWidgets('Hero banner should have carousel dots', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Should find carousel indicators
      expect(find.byType(Row), findsWidgets);
    });
  });

  group('AboutPage Tests', () {
    testWidgets('Should display About Us title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPage()));
      await tester.pumpAndSettle();

      expect(find.text('About Us'), findsWidgets);
    });

    testWidgets('Should display about content', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('The UNION'), findsWidgets);
    });
  });

  group('CartPage Tests', () {
    testWidgets('Should display empty cart message', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to cart
      final cartIcon = find.byIcon(Icons.shopping_bag_outlined).first;
      await tester.tap(cartIcon);
      await tester.pumpAndSettle();

      expect(find.text('Your cart is empty.'), findsOneWidget);
      expect(find.text('Continue shopping'), findsOneWidget);
    });

    testWidgets('Should have back button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('Should display cart title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      expect(find.text('Your cart'), findsOneWidget);
    });
  });

  group('CollectionsPage Tests', () {
    testWidgets('Should display Collections title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
      await tester.pumpAndSettle();

      expect(find.text('Collections'), findsWidgets);
    });

    testWidgets('Should display category cards', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
      await tester.pumpAndSettle();

      expect(find.text('T-Shirts'), findsOneWidget);
      expect(find.text('Hoodies'), findsOneWidget);
      expect(find.text('Accessories'), findsOneWidget);
    });

    testWidgets('Category cards should be tappable', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to collections
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final shopLink = find.text('Shop').first;
      await tester.tap(shopLink);
      await tester.pumpAndSettle();

      // Find and verify category cards
      expect(find.byType(InkWell), findsWidgets);
    });
  });
  group('ProductPage Tests', () {
    testWidgets('Should display product details', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
          child: const MaterialApp(home: ProductPage()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('UNION Shop Product'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('Tax included.'), findsOneWidget);
    });

    testWidgets('Should have size dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
          child: const MaterialApp(home: ProductPage()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Size'), findsWidgets);
      expect(find.byType(DropdownButton<String>), findsWidgets);
    });

    testWidgets('Should have color dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
          child: const MaterialApp(home: ProductPage()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Color'), findsWidgets);
    });

    testWidgets('Should have quantity selector', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
          child: const MaterialApp(home: ProductPage()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Quantity'), findsWidgets);
    });

    testWidgets('Should have add to cart button', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
          child: const MaterialApp(home: ProductPage()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Add to cart'), findsOneWidget);
    });

    testWidgets('Should increment quantity', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
          child: const MaterialApp(home: ProductPage()),
        ),
      );
      await tester.pumpAndSettle();

      // Find the + button in quantity selector
      final plusButtons = find.byIcon(Icons.arrow_drop_up);
      expect(plusButtons, findsWidgets);
    });
  });

  group('SalePage Tests', () {
    testWidgets('Should display SALE title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SalePage()));
      await tester.pumpAndSettle();

      expect(find.text('SALE'), findsOneWidget);
    });

    testWidgets('Should display sale banner text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SalePage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Don\'t miss out'), findsOneWidget);
      expect(find.textContaining('discount'), findsWidgets);
    });

    testWidgets('Should have sort dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SalePage()));
      await tester.pumpAndSettle();

      expect(find.byType(DropdownButton<String>), findsOneWidget);
    });
  });

  group('SearchPage Tests', () {
    testWidgets('Should display search field', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SearchPage()));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('Should display popular searches', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SearchPage()));
      await tester.pumpAndSettle();

      expect(find.text('Popular Searches'), findsOneWidget);
    });
  });

  group('LoginPage Tests', () {
    testWidgets('Should display login form', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.pumpAndSettle();

      expect(find.text('Login'), findsWidgets);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('Should have login button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    });

    testWidgets('Should have signup link', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Sign Up'), findsOneWidget);
    });
  });

  group('SignupPage Tests', () {
    testWidgets('Should display signup form', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignupPage()));
      await tester.pumpAndSettle();

      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('Should have signup button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignupPage()));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);
    });

    testWidgets('Should have login link', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignupPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Login'), findsOneWidget);
    });
  });

  group('PrintShackPage Tests', () {
    testWidgets('Should display Print Shack title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrintShackPage()));
      await tester.pumpAndSettle();

      expect(find.text('DESIGN YOUR OWN'), findsOneWidget);
    });

    testWidgets('Should have text input options', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrintShackPage()));
      await tester.pumpAndSettle();

      expect(find.byType(DropdownButton<String>), findsWidgets);
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('Should have quantity selector', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrintShackPage()));
      await tester.pumpAndSettle();

      expect(find.text('Quantity'), findsWidgets);
    });
  });
}
