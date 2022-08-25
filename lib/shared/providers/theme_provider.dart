import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/shared/providers/shared_utility_provider.dart';

final themeModeProvider = ChangeNotifierProvider<ThemeModeNotifier>((ref) {
  return ThemeModeNotifier(ref);
});

class ThemeModeNotifier extends ChangeNotifier {
  ThemeModeNotifier(this.ref);
  Ref ref;

  void setThemeMode(ThemeMode themeMode) {
    ref.watch(sharedUtilityProvider).setThemeMode(themeMode);
    notifyListeners();
  }

  ThemeMode loadThemeMode() {
    return ref.watch(sharedUtilityProvider).loadThemeMode();
  }
}
