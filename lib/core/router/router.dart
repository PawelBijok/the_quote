import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/list_extensions.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/collection/presentation/pages/add_or_edit_collection/add_or_edit_collection_page.dart';
import 'package:the_quote/features/collection/presentation/pages/collection/collection_page.dart';
import 'package:the_quote/features/email_base_auth/presentation/pages/continue_with_email_page.dart';
import 'package:the_quote/features/main_screen/presentation/main_page.dart';
import 'package:the_quote/features/start/presentation/pages/initialization_page.dart';
import 'package:the_quote/features/start/presentation/pages/start_page.dart';

final router = GoRouter(
  refreshListenable: getIt<AuthCubit>(),
  initialLocation: Routes.root,
  redirect: (context, state) {
    final location = state.location;

    final authState = getIt<AuthCubit>().state;
    return authState.mapOrNull(
      signedIn: (_) {
        if (!Routes.authenticatedPaths.containsPart(location)) {
          return Routes.main;
        }
        return null;
      },
      signedOut: (_) {
        if (!Routes.unauthenticatedPaths.containsPart(location)) {
          return Routes.start;
        }
        return null;
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
      path: Routes.main,
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: Routes.addOrEditCollection,
      builder: (context, state) {
        final collection = state.extra is CollectionModel ? state.extra! as CollectionModel : null;
        return AddOrEditCollectionPage(
          collectionToEdit: collection,
        );
      },
    ),
    GoRoute(
      path: '${Routes.collection}/:id',
      builder: (context, state) {
        final preloadedCollection = state.extra is CollectionModel ? state.extra! as CollectionModel : null;
        return CollectionPage(
          id: state.pathParameters['id']!,
          preloadedCollection: preloadedCollection,
        );
      },
    ),
  ],
);
