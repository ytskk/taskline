import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/shared/shared.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  final sharedUtil = ref.watch(sharedUtilityProvider);

  return TaskListNotifier(
    [],
    sharedUtil,
  );
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier(super.initialTasks, this.sharedUtility);

  final SharedUtility sharedUtility;

  void _saveTasks() {
    sharedUtility.saveTasks(state);
  }

  void loadTasks() {
    final data = sharedUtility.loadTasks();

    state = data;
  }

  /// Add new [Task] to the list.
  ///
  /// Creates [Task] from provided name.
  void add(String name, {String? taskId}) {
    if (taskId == null) {
      taskId = _uuid.v4();
    }

    final task = Task(
      id: taskId,
      name: name,
      status: TaskStatus.todo,
    );

    state = [...state, task];
    _saveTasks();
  }

  String getUuid() {
    return _uuid.v4();
  }

  /// It changes the status of the [task] to the next status.
  void toggleTaskStatus(Task task) {
    final updatedTask = task.copyWith(
      status: TaskStatus.nextStatus(task.status),
    );
    state = state.map((t) => t.id == updatedTask.id ? updatedTask : t).toList();
    _saveTasks();
  }

  void remove(Task task) {
    state = state.where((t) => t.id != task.id).toList();
    _saveTasks();
  }

  void clear() {
    state = [];
    _saveTasks();
  }

  /// Updates [name] of Task by [id].
  void edit({
    required String id,
    String? name,
    TaskStatus? status,
  }) {
    state = state
        .map(
          (task) => task.id == id
              ? task.copyWith(
                  name: name,
                  status: status,
                )
              : task,
        )
        .toList();
    _saveTasks();
  }
}
