import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pipboyapp/core/pip_theme.dart';
import 'package:pipboyapp/screens/pipboy_home.dart';

void main() {
  group('PipBoyHome', () {
    Future<void> open(WidgetTester tester,
        {Size size = const Size(390, 844), double scale = 1}) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      // Use the terminal's fallback font to keep tests independent of font downloads.
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: PipColors.background),
        home: const PipBoyHome(),
      ));
    }

    Future<void> tab(WidgetTester tester, String label) async {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
    }

    Future<void> tapVisible(WidgetTester tester, String key) async {
      final finder = find.byKey(ValueKey(key));
      final scrollable = find.byWidgetPredicate((widget) =>
          widget is Scrollable && widget.axisDirection == AxisDirection.down);
      await tester.drag(scrollable, const Offset(0, 2000));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(finder, 100, scrollable: scrollable);
      await tester.ensureVisible(finder);
      await tester.pumpAndSettle();
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }

    testWidgets('should preserve inventory effects and equipment across tabs',
        (tester) async {
      await open(tester);
      expect(find.text('HP 82/82'), findsOneWidget);
      await tab(tester, 'INV');
      await tapVisible(tester, 'equip-laser');
      await tapVisible(tester, 'use-radaway');
      expect(find.text('HP 82/100'), findsOneWidget);
      await tab(tester, 'STAT');
      expect(find.text('DMG 24 // DR 0'), findsOneWidget);
      await tab(tester, 'INV');
      await tapVisible(tester, 'use-stimpak');
      expect(find.text('HP 100/100'), findsOneWidget);
      await tab(tester, 'STAT');
      expect(find.text('CONDITION: HEALTHY'), findsOneWidget);
    });

    testWidgets('should track quests on the map and complete objectives',
        (tester) async {
      await open(tester);
      await tab(tester, 'DATA');
      await tapVisible(tester, 'objective-signal-0');
      expect(find.text('1/3 OBJECTIVES // REWARD 150 CAPS'), findsOneWidget);
      await tapVisible(tester, 'track-water');
      await tab(tester, 'MAP');
      final icon = tester
          .widget<IconButton>(find.byKey(const ValueKey('marker-purifier')));
      expect((icon.icon as Icon).icon, Icons.flag);
      await tapVisible(tester, 'location-bunker');
      await tapVisible(tester, 'discover-location');
      expect(find.text('GRID 5B // DISCOVERED'), findsOneWidget);
      await tapVisible(tester, 'toggle-waypoint');
      expect(find.text('CLEAR WAYPOINT'), findsOneWidget);
      await tab(tester, 'DATA');
      expect(find.text('1/3 OBJECTIVES // REWARD 150 CAPS'), findsOneWidget);
    });

    testWidgets(
        'should retain selected radio station and receiver power across tabs',
        (tester) async {
      await open(tester);
      await tab(tester, 'RADIO');
      await tapVisible(tester, 'station-beacon');
      await tapVisible(tester, 'radio-power');
      expect(find.text('TRANSMISSION: Survivors: proceed to Relay Tower Beta.'),
          findsOneWidget);
      await tab(tester, 'STAT');
      await tab(tester, 'RADIO');
      expect(find.text('RECEIVER ON'), findsOneWidget);
      expect(
          tester
              .widget<Slider>(find.byKey(const ValueKey('radio-volume')))
              .onChanged,
          isNotNull);
    });

    for (final size in [const Size(320, 568), const Size(844, 390)]) {
      testWidgets(
          'should render all tabs without overflow at $size with enlarged text',
          (tester) async {
        await open(tester, size: size, scale: 1.4);
        for (final label in ['STAT', 'INV', 'DATA', 'MAP', 'RADIO']) {
          await tab(tester, label);
          expect(tester.takeException(), isNull,
              reason: 'Layout failed on $label');
        }
      });
    }
  });
}
