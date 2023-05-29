import 'package:flutter/material.dart';
import 'package:the_quote_core_ui/the_quote_core_ui.dart';
import 'package:the_quote_localization/the_quote_localization.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          LocaleKeys.hi.tr(),
        ),
      ),
    );
  }
}
