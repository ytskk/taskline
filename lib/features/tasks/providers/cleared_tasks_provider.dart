import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';

/// Hides completed tasks.
final clearedTasksProvider = Provider<List<Task>>(
  (ref) {
    final List<Task> tasks = ref.watch(taskListProvider);
    final Period clearPeriod = ref.watch(tasksClearPeriodProvider);
    log('all tasks: ${tasks.length}');

    return tasks
        .where(
          (task) => TasksClearPeriodNotifier.isTaskUnderClearPeriod(
            task,
            clearPeriod,
          ),
        )
        .toList();
  },
);
