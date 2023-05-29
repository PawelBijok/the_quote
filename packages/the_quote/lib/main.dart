import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_quote/core/app/app.dart';
import 'package:the_quote/core/config/firebase_options.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote_localization/the_quote_localization.dart';

Future<void> main() async {
  await init();
  runApp(const LocalizationWrapper(child: App()));
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Future.wait([
    TheQuoteLocalization.ensureInitialized(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
  ]);
}
