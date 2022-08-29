import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/shared/providers/shared_utility_provider.dart';

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final sharedUtility = ref.watch(sharedUtilityProvider);

  return ThemeModeNotifier(sharedUtility: sharedUtility);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier({
    required this.sharedUtility,
  }) : super(sharedUtility.loadThemeMode());

  final SharedUtility sharedUtility;

  void _saveThemeMode() {
    sharedUtility.saveThemeMode(state);
  }

  void setThemeMode(ThemeMode themeMode) {
    state = themeMode;

    _saveThemeMode();
  }

  void loadThemeMode() {
    final data = sharedUtility.loadThemeMode();

    state = data;
  }
}
