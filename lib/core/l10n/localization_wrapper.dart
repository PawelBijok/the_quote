import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_quote/core/l10n/supported_locales.dart';

class LocalizationWrapper extends StatelessWidget {
  const LocalizationWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: SupportedLocales.all,
      useOnlyLangCode: true,
      path: 'assets/translations/',
      fallbackLocale: SupportedLocales.fallback,
      child: child,
    );
  }
}
