import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_quote/core/app/app.dart';
import 'package:the_quote/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}
