import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:the_quote/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SafeArea(
          child: DefaultPagePadding(
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      LocaleKeys.appThemeMode.tr(),
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  Spacers.m,
                  ListTile(
                    title: Text(LocaleKeys.lightTheme.tr()),
                    contentPadding: const EdgeInsets.symmetric(vertical: 2),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.light,
                      groupValue: state.themeMode,
                      onChanged: context.read<SettingsCubit>().setThemeMode,
                    ),
                  ),
                  ListTile(
                    title: Text(LocaleKeys.darkTheme.tr()),
                    contentPadding: const EdgeInsets.symmetric(vertical: 2),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.dark,
                      groupValue: state.themeMode,
                      onChanged: context.read<SettingsCubit>().setThemeMode,
                    ),
                  ),
                  ListTile(
                    title: Text(LocaleKeys.systemTheme.tr()),
                    contentPadding: const EdgeInsets.symmetric(vertical: 2),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.system,
                      groupValue: state.themeMode,
                      onChanged: context.read<SettingsCubit>().setThemeMode,
                    ),
                  ),
                  const Spacer(),
                  const Divider(),
                  Spacers.s,
                  ElevatedButton.icon(
                    onPressed: () {
                      getIt<AuthCubit>().logout();
                      context.go(Routes.start);
                    },
                    icon: const Icon(Icons.logout_outlined),
                    label: Text(LocaleKeys.signOut.tr()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
