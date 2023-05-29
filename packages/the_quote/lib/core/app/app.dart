import 'package:flutter/material.dart';
import 'package:the_quote_core_ui/the_quote_core_ui.dart';
import 'package:the_quote_localization/the_quote_localization.dart';
import 'package:the_quote_router/the_quote_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      routerConfig: TheQuoteRouter.router,
    );
  }
}
