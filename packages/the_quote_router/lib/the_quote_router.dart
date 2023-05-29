library the_quote_router;

import 'package:go_router/go_router.dart';

import './src/router/router.dart' as r;

class TheQuoteRouter {
  static GoRouter get router => r.router;
}
