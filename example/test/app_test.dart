import 'package:example/constants.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('desktop size', () {
    testWidgets('app from menu navigates to profile and back to home',
        (WidgetTester tester) async {
      // arrange
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(const ExampleApp());
      await tester.pumpAndSettle();

      // assert initially at home with menu
      expect(find.text(textMenuTitle), findsOneWidget);
      expect(find.text(textHomeTitle), findsWidgets);
      final profileItem = find.text(textProfileTitle);
      expect(profileItem, findsOneWidget);

      // act: navigates to profile
      await tester.tap(profileItem);
      await tester.pumpAndSettle();

      // assert at profile with menu
      expect(find.text(textMenuTitle), findsOneWidget);
      expect(find.text(textProfileTitle), findsWidgets);
      final backItem = find.byIcon(iconBack);
      expect(backItem, findsWidgets);

      // act: navigates back
      await tester.tap(backItem);
      await tester.pumpAndSettle();

      // assert at home with menu
      expect(find.text(textMenuTitle), findsOneWidget);
      expect(find.text(textHomeTitle), findsWidgets);
    });
  });
}
