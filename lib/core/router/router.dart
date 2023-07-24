import 'package:go_router/go_router.dart';
import 'package:the_quote/features/start/presentation/pages/start_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const StartPage()),
  ],
);
