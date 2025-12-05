// filepath: test/responsive_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/utils/responsive.dart';

void main() {
  group('ResponsiveHelper Tests', () {
    testWidgets('isMobile should return true for small screens', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveHelper.isMobile(context), true);
              expect(ResponsiveHelper.isTablet(context), false);
              expect(ResponsiveHelper.isDesktop(context), false);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('isTablet should return true for medium screens', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(800, 600);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveHelper.isMobile(context), false);
              expect(ResponsiveHelper.isTablet(context), true);
              expect(ResponsiveHelper.isDesktop(context), false);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('isDesktop should return true for large screens', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveHelper.isMobile(context), false);
              expect(ResponsiveHelper.isTablet(context), false);
              expect(ResponsiveHelper.isDesktop(context), true);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('value should return mobile value on mobile', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final value = ResponsiveHelper.value(
                context: context,
                mobile: 10.0,
                tablet: 20.0,
                desktop: 30.0,
              );
              expect(value, 10.0);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('value should return tablet value on tablet', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(800, 600);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final value = ResponsiveHelper.value(
                context: context,
                mobile: 10.0,
                tablet: 20.0,
                desktop: 30.0,
              );
              expect(value, 20.0);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('value should return desktop value on desktop', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final value = ResponsiveHelper.value(
                context: context,
                mobile: 10.0,
                tablet: 20.0,
                desktop: 30.0,
              );
              expect(value, 30.0);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('fontSize should return correct sizes', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final fontSize = ResponsiveHelper.fontSize(
                context: context,
                mobile: 12.0,
                desktop: 16.0,
              );
              expect(fontSize, 12.0);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('gridColumns should return correct columns', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final columns = ResponsiveHelper.gridColumns(
                context,
                mobile: 1,
                tablet: 2,
                desktop: 3,
              );
              expect(columns, 1);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('padding should return correct padding', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final padding = ResponsiveHelper.padding(context);
              expect(padding, 16.0);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('spacing should return correct spacing', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final spacing = ResponsiveHelper.spacing(context);
              expect(spacing, 12.0);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('horizontalPadding should return correct padding', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final padding = ResponsiveHelper.horizontalPadding(context);
              expect(padding, 16.0);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('verticalPadding should return correct padding', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final padding = ResponsiveHelper.verticalPadding(context);
              expect(padding, 16.0);
              return Container();
            },
          ),
        ),
      );
    });
  });

  group('ResponsiveBuilder Tests', () {
    testWidgets('Should build mobile layout on mobile', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveBuilder(
            mobile: (context) => const Text('Mobile'),
            tablet: (context) => const Text('Tablet'),
            desktop: (context) => const Text('Desktop'),
          ),
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
      expect(find.text('Tablet'), findsNothing);
      expect(find.text('Desktop'), findsNothing);
    });

    testWidgets('Should build tablet layout on tablet', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(800, 600);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveBuilder(
            mobile: (context) => const Text('Mobile'),
            tablet: (context) => const Text('Tablet'),
            desktop: (context) => const Text('Desktop'),
          ),
        ),
      );

      expect(find.text('Mobile'), findsNothing);
      expect(find.text('Tablet'), findsOneWidget);
      expect(find.text('Desktop'), findsNothing);
    });

    testWidgets('Should build desktop layout on desktop', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveBuilder(
            mobile: (context) => const Text('Mobile'),
            tablet: (context) => const Text('Tablet'),
            desktop: (context) => const Text('Desktop'),
          ),
        ),
      );

      expect(find.text('Mobile'), findsNothing);
      expect(find.text('Tablet'), findsNothing);
      expect(find.text('Desktop'), findsOneWidget);
    });
  });
}
