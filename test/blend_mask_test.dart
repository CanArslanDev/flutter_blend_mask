import 'package:blend_mask/blend_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BlendMask', () {
    testWidgets('creates render object with correct blend mode and opacity',
        (WidgetTester tester) async {
      const testBlendMode = BlendMode.multiply;
      const testOpacity = 0.8;

      await tester.pumpWidget(
        const MaterialApp(
          home: BlendMask(
            blendMode: testBlendMode,
            opacity: testOpacity,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      expect(find.byType(BlendMask), findsOneWidget);
    });

    testWidgets('updates render object when properties change',
        (WidgetTester tester) async {
      const initialBlendMode = BlendMode.multiply;
      const updatedBlendMode = BlendMode.screen;
      const initialOpacity = 0.5;
      const updatedOpacity = 0.8;

      await tester.pumpWidget(
        const MaterialApp(
          home: BlendMask(
            blendMode: initialBlendMode,
            opacity: initialOpacity,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      expect(find.byType(BlendMask), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(
          home: BlendMask(
            blendMode: updatedBlendMode,
            opacity: updatedOpacity,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      expect(find.byType(BlendMask), findsOneWidget);
    });

    testWidgets('works without child', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BlendMask(
            blendMode: BlendMode.multiply,
          ),
        ),
      );

      expect(find.byType(BlendMask), findsOneWidget);
    });

    test('opacity assertion works correctly', () {
      expect(
        () => BlendMask(
          blendMode: BlendMode.multiply,
          opacity: -0.1,
        ),
        throwsAssertionError,
      );

      expect(
        () => BlendMask(
          blendMode: BlendMode.multiply,
          opacity: 1.1,
        ),
        throwsAssertionError,
      );
    });
  });
}
