import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petbuddy/main.dart';

void main() {
  group('Responsive Layout Tests', () {
    testWidgets('App renders on phone-sized screen', (WidgetTester tester) async {
      // Set device size to phone (portrait)
      addTearDown(tester.binding.window.physicalSizeTestValue = const Size(360, 800));
      addTearDown(
        () => tester.binding.window.clearPhysicalSizeTestValue(),
      );

      await tester.pumpWidget(const MyApp());

      // Verify title appears
      expect(find.text('PetBuddy'), findsOneWidget);

      // Verify pet grid is present
      expect(find.byType(GridView), findsOneWidget);

      // Verify footer buttons exist
      expect(find.byIcon(Icons.list), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('App renders on tablet-sized screen', (WidgetTester tester) async {
      // Set device size to tablet (portrait)
      addTearDown(tester.binding.window.physicalSizeTestValue = const Size(820, 1180));
      addTearDown(
        () => tester.binding.window.clearPhysicalSizeTestValue(),
      );

      await tester.pumpWidget(const MyApp());

      // Verify app renders without errors
      expect(find.text('PetBuddy'), findsOneWidget);
    });

    testWidgets('App renders in landscape orientation', (WidgetTester tester) async {
      // Set device size to landscape
      addTearDown(tester.binding.window.physicalSizeTestValue = const Size(800, 360));
      addTearDown(
        () => tester.binding.window.clearPhysicalSizeTestValue(),
      );

      await tester.pumpWidget(const MyApp());

      expect(find.text('PetBuddy'), findsOneWidget);
    });

    testWidgets('Pet cards are tappable', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find and tap a pet card
      await tester.tap(find.byType(Card).first);
      await tester.pumpAndSettle();

      // Verify snackbar appears
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Adopt button shows snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Scroll to ensure adopt button is visible
      await tester.scrollUntilVisible(
        find.text('Adopt').first,
        500.0,
      );

      // Tap adopt button
      await tester.tap(find.text('Adopt').first);
      await tester.pumpAndSettle();

      // Verify snackbar with adoption message
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Footer buttons are all present', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify all footer buttons exist
      expect(find.byIcon(Icons.list), findsWidgets);
      expect(find.byIcon(Icons.favorite), findsWidgets);
      expect(find.byIcon(Icons.pets), findsWidgets);
      expect(find.byIcon(Icons.settings), findsWidgets);
    });
  });
}
