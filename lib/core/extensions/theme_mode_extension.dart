import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  Brightness? get brightness {
    return switch (this) {
      ThemeMode.dark => Brightness.dark,
      ThemeMode.light => Brightness.light,
      ThemeMode.system => null,
    };
  }
}
