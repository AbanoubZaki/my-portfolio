import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portofolio/l10n/l10n.dart';
import 'package:my_portofolio/widgets/projects_section.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  testWidgets('ProjectsSection lays out at desktop & mobile without errors',
      (tester) async {
    // Fire Reveal's VisibilityDetector synchronously so no debounce Timer
    // remains pending at teardown.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    Widget app() => MaterialApp(
          supportedLocales: kSupportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: const Scaffold(
            body: SingleChildScrollView(child: ProjectsSection()),
          ),
        );

    // Desktop width -> featured horizontal card + 3-col grid.
    tester.view.physicalSize = const Size(1400, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    // Mobile width -> featured falls back to vertical card, 1-col grid.
    tester.view.physicalSize = const Size(390, 6000);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
