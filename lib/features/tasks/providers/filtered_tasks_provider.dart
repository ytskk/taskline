import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/shared/providers/filtered_tasks.dart';

final filteredProvider = Provider<List<Task>>(
  (ref) {
    final TaskFilter filter = ref.watch(taskFilterProvider);
    final List<Task> tasks = ref.watch(clearedTasksProvider);

    switch (filter) {
      case TaskFilter.all:
        return tasks;
      case TaskFilter.todo:
        return tasks.where((task) => task.status == TaskStatus.todo).toList();
      case TaskFilter.inProgress:
        return tasks
            .where((task) => task.status == TaskStatus.inProgress)
            .toList();
      case TaskFilter.completed:
        return tasks.where((task) => task.status == TaskStatus.done).toList();
    }
  },
);
