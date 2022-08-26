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

  void getPreferencesString() {
    final String themeMode = _loadThemeModeString() ?? '';
    final String tasks = _loadTasksString() ?? 'system';
    final int tasksClearPeriod = loadTasksClearPeriod();

    final Map<String, String> preferencesMap = {
      'themeMode': themeMode,
      'tasks': tasks,
      'taskClearPeriod': tasksClearPeriod.toString(),
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

  void saveClearTasksPeriod(int clearTasksPeriod) {
    sharedPreferences.setInt(sharedPrefsTasksClearPeriodKey, clearTasksPeriod);
  }

  String? _loadTasksString() {
    final json = sharedPreferences.getString(sharedPrefsTasksKey);

    return json;
  }

  List<Task> loadTasks() {
    final json = _loadTasksString();
    // final int clearPeriod = loadTasksClearPeriod();

    if (json == null || json.isEmpty) {
      return [];
    }

    final List<dynamic> jsonTasks = jsonDecode(json);

    final List<Task> tasks = jsonTasks
        .map(
          (jsonTask) => Task.fromJson(jsonTask),
        )
        .toList();

    return tasks;
  }

  void setTasksClearPeriod(int clearTasksPeriod) {
    sharedPreferences.setInt(sharedPrefsTasksClearPeriodKey, clearTasksPeriod);
  }

  int loadTasksClearPeriod() {
    return sharedPreferences.getInt(sharedPrefsTasksClearPeriodKey) ?? -1;
  }

  void saveThemeMode(ThemeMode themeMode) {
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
