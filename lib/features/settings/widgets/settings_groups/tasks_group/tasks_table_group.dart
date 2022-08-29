import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';

class SettingsTasksTableGroup extends ConsumerWidget {
  const SettingsTasksTableGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsTable(
      title: 'Tasks',
      children: [
        const SettingsClearLine(),
        const SettingsClearCompletedTasksPeriod(),
      ],
    );
  }
}
