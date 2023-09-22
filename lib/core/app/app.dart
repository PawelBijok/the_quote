import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/router/router.dart';
import 'package:the_quote/core/themes/themes.dart';
import 'package:the_quote/features/auth/presentation/cubit/auth_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: BlocProvider(
        create: (context) => getIt<AuthCubit>()..tryAutoLogin(),
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          routerConfig: router,
        ),
      ),
    );
  }
}
