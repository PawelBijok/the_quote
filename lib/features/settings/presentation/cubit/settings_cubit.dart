import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(themeMode: ThemeMode.system));
  static const _themeModeKey = 'theme_mode_the_quote';
  Future<void> init() async {
    final preferences = await SharedPreferences.getInstance();
    final themeModeName = preferences.getString(_themeModeKey);
    final themeMode = ThemeMode.values.firstWhereOrNull((element) => element.name == themeModeName);
    emit(state.copyWith(themeMode: themeMode ?? ThemeMode.system));
  }

  Future<void> setThemeMode(ThemeMode? themeMode) async {
    if (themeMode == null) return;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_themeModeKey, themeMode.name);
    emit(state.copyWith(themeMode: themeMode));
  }
}
