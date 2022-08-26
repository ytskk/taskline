import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskline/constants/constants.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/shared/providers/providers.dart';

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

  void getPreferencesString() {
    final String themeMode = _loadThemeModeString() ?? '';
    final String tasks = _loadTasksString() ?? 'system';

    final Map<String, String> preferencesMap = {
      'themeMode': themeMode,
      'tasks': tasks,
    };

    final String json = jsonEncode(preferencesMap);

    log('json: $json');
  }

  void saveTasks(List<Task> tasks) {
    if (tasks.isNotEmpty) {
      final String json = jsonEncode(tasks);

      sharedPreferences.setString(sharedPrefsTasksKey, json);

      return;
    }

    sharedPreferences.setString(sharedPrefsTasksKey, '');
  }

  String? _loadTasksString() {
    final json = sharedPreferences.getString(sharedPrefsTasksKey);

    return json;
  }

  List<Task> loadTasks() {
    final json = _loadTasksString();

    if (json == null || json.isEmpty) {
      return [];
    }

    final List<dynamic> jsonTasks = jsonDecode(json);

    final List<Task> tasks =
        jsonTasks.map((jsonTask) => Task.fromJson(jsonTask)).toList();

    return tasks;
  }

  void setThemeMode(ThemeMode themeMode) {
    log('setThemeMode: $themeMode');
    sharedPreferences.setString(sharedPrefsThemeModeKey, themeMode.name);
  }

  String? _loadThemeModeString() {
    final themeModeValue = sharedPreferences.getString(sharedPrefsThemeModeKey);

    return themeModeValue;
  }

  ThemeMode loadThemeMode() {
    final themeModeValue = _loadThemeModeString();

    return ThemeMode.values.firstWhere(
      (themeMode) => themeMode.name == themeModeValue,
      orElse: () => ThemeMode.system,
    );
  }
}
