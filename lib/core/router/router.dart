import 'package:go_router/go_router.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:the_quote/features/email_base_auth/presentation/pages/continue_with_email_page.dart';
import 'package:the_quote/features/home/presentation/page/home_page.dart';
import 'package:the_quote/features/start/presentation/pages/initialization_page.dart';
import 'package:the_quote/features/start/presentation/pages/start_page.dart';

String? _checkRouterStateAndRedirect({
  required GoRouterState state,
  required String desiredRoute,
  String? optionalRouteToStayIn,
}) {
  if (state.location.contains(desiredRoute)) {
    return null;
  }
  if (optionalRouteToStayIn != null &&
      state.location.contains(
        optionalRouteToStayIn,
      )) {
    return null;
  }

  return desiredRoute;
}

final router = GoRouter(
  refreshListenable: getIt<AuthCubit>(),
  redirect: (context, state) {
    final authState = getIt<AuthCubit>().state;
    return authState.mapOrNull(
      signedIn: (_) {
        return _checkRouterStateAndRedirect(
          state: state,
          desiredRoute: Routes.home,
        );
      },
      signedOut: (_) {
        return _checkRouterStateAndRedirect(
          state: state,
          desiredRoute: Routes.start,
        );
      },
    );
  },
  routes: [
    GoRoute(
      path: Routes.root,
      builder: (context, state) => const InitializationPage(),
    ),
    GoRoute(path: Routes.start, builder: (context, state) => const StartPage()),
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
