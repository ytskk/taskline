import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/shared/shared.dart';

final tasksClearPeriodProvider =
    StateNotifierProvider<TasksClearPeriodNotifier, int>((ref) {
  final sharedUtil = ref.watch(sharedUtilityProvider);

  return TasksClearPeriodNotifier(sharedUtility: sharedUtil);
});

class TasksClearPeriodNotifier extends StateNotifier<int> {
  TasksClearPeriodNotifier({required this.sharedUtility}) : super(-1);

  final SharedUtility sharedUtility;

  void saveTasksClearPeriod(int clearTasksPeriod) {
    sharedUtility.saveClearTasksPeriod(clearTasksPeriod);
  }

  void loadTasksClearPeriod() {
    final clearTasksPeriod = sharedUtility.loadTasksClearPeriod();

    state = clearTasksPeriod;
  }

  void setTasksClearPeriod(int clearTasksPeriod) {
    state = clearTasksPeriod;

    saveTasksClearPeriod(clearTasksPeriod);
  }
}
