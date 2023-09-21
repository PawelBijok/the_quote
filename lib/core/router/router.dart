import 'package:go_router/go_router.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/features/email_base_auth/presentation/pages/continue_with_email_page.dart';
import 'package:the_quote/features/home/presentation/page/home_page.dart';
import 'package:the_quote/features/start/presentation/pages/start_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: Routes.root, builder: (context, state) => const StartPage()),
    GoRoute(
      path: Routes.continueWithEmail,
      builder: (context, state) => const ContinueWithEmailPage(),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
