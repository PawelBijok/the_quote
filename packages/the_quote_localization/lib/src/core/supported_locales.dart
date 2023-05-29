import 'dart:ui';

abstract class SupportedLocales {
  static const List<Locale> all = [
    Locale('en', 'US'),
    Locale('pl', 'PL'),
  ];

  static const Locale fallback = Locale('en', 'US');
}
