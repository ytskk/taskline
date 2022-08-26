import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/shared/providers/tasks_clear_period_provider.dart';
import 'package:taskline/shared/shared.dart';

final clearedTasksProvider = Provider<List<Task>>(
  (ref) {
    final tasks = ref.watch(taskListProvider);
    final clearPeriod = ref.watch(tasksClearPeriodProvider);

    return tasks.where(
      (task) {
        /// Filter if [clearPeriod] is set and task is completed.
        ///
        /// Assumption: [clearPeriod] if clear period is -1, period is unlimited.
        if (clearPeriod != -1 && task.completedAt != null) {
          if (DateTime.now().difference(task.completedAt!).inDays >=
              clearPeriod) {
            return false;
          }
        }

        return true;
      },
    ).toList();
  },
);
