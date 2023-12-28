import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:the_quote/core/extensions/theme_mode_extension.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/router/router.dart';
import 'package:the_quote/core/themes/themes.dart';
import 'package:the_quote/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:the_quote/features/settings/presentation/cubit/settings_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AuthCubit>()..tryAutoLogin(),
          ),
          BlocProvider(
            create: (context) => getIt<SettingsCubit>()..init(),
          ),
        ],
        child: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle.dark.copyWith(
                statusBarBrightness: state.themeMode.brightness,
              ),
            );
          },
          builder: (context, settingsState) {
            return MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: Themes.lightTheme,
              themeMode: settingsState.themeMode,
              darkTheme: Themes.darkTheme,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
