import 'package:flutter/widgets.dart';

/// App-wide selected locale. Toggled from the nav bar / drawer.
final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));

const List<Locale> kSupportedLocales = [Locale('en'), Locale('de')];

/// A bilingual string. Resolve against the current locale with [of].
class L {
  const L(this.en, this.de);
  final String en;
  final String de;

  String of(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'de' ? de : en;
}

extension LocaleX on BuildContext {
  bool get isDe => Localizations.localeOf(this).languageCode == 'de';

  /// Inline translation helper for widget chrome strings.
  String tr(String en, String de) => isDe ? de : en;
}
