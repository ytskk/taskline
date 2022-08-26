import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskline/constants/constants.dart';
import 'package:taskline/features/features.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final _sharedPrefs = ref.watch(sharedPreferencesProvider);

  return SharedUtility(sharedPreferences: _sharedPrefs);
});

class SharedUtility {
  const SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  void saveTasks(List<Task> tasks) {
    // log('saving tasks: $tasks', name: 'SharedUtility::saveTasks');
    if (tasks.isNotEmpty) {
      final String json = jsonEncode(tasks);
      // print(json);

      sharedPreferences.setString(sharedPrefsTasksKey, json);

      return;
    }

    sharedPreferences.setString(sharedPrefsTasksKey, '');
  }

  List<Task> loadTasks() {
    final json = sharedPreferences.getString(sharedPrefsTasksKey);

    if (json == null || json.isEmpty) {
      return [];
    }

    final List<dynamic> jsonTasks = jsonDecode(json);

    final List<Task> tasks =
        jsonTasks.map((jsonTask) => Task.fromJson(jsonTask)).toList();
    // log('loading tasks: $tasks', name: 'SharedUtility::loadTasks');

    return tasks;
  }

  void setThemeMode(ThemeMode themeMode) {
    log('setThemeMode: $themeMode');
    sharedPreferences.setString(sharedPrefsThemeModeKey, themeMode.name);
  }

  ThemeMode loadThemeMode() {
    final themeModeValue = sharedPreferences.getString(sharedPrefsThemeModeKey);
    log('loading theme from shared prefs: $themeModeValue');

    return ThemeMode.values.firstWhere(
      (themeMode) => themeMode.name == themeModeValue,
      orElse: () => ThemeMode.system,
    );
  }
}
