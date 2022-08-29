import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/shared/shared.dart';

/// Control clear period of completed tasks.
final tasksClearPeriodProvider =
    StateNotifierProvider<TasksClearPeriodNotifier, Period>((ref) {
  final sharedUtil = ref.watch(sharedUtilityProvider);

  return TasksClearPeriodNotifier(sharedUtility: sharedUtil);
});

class TasksClearPeriodNotifier extends StateNotifier<Period> {
  TasksClearPeriodNotifier({required this.sharedUtility})
      : super(sharedUtility.loadTasksClearPeriod());

  final SharedUtility sharedUtility;

  void saveTasksClearPeriod(Period clearTasksPeriod) {
    sharedUtility.saveClearTasksPeriod(clearTasksPeriod);
  }

  void loadTasksClearPeriod() {
    log(
      'reading tasks clear period from shared preferences',
      name: 'TasksClearPeriodNotifier::loadTasksClearPeriod',
    );
    final clearTasksPeriod = sharedUtility.loadTasksClearPeriod();

    state = clearTasksPeriod;
  }

  void setTasksClearPeriod(Period clearTasksPeriod) {
    state = clearTasksPeriod;

    saveTasksClearPeriod(clearTasksPeriod);
  }

  /// Filters if [task.completedAt] not null and [task.completedAt] is older
  /// than [clearPeriod].
  static bool isTaskUnderClearPeriod(
    Task task,
    Period clearPeriod,
  ) {
    final bool needsToCheck =
        clearPeriod.inDays != -1 && task.completedAt != null;

    if (needsToCheck) {
      final bool isOld = DateTime.now().difference(task.completedAt!).inDays >=
          clearPeriod.inDays;

      if (isOld) {
        return false;
      }
    }

    return true;
  }
}
