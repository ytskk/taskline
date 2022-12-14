import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/shared/shared.dart';
import 'package:uuid/uuid.dart';

// const _uuid = Uuid();
const _uuid = Uuid();

/// Provider list of all saved tasks.
final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  final sharedUtil = ref.watch(sharedUtilityProvider);
  final clearPeriod = ref.watch(tasksClearPeriodProvider);

  return TaskListNotifier(
    sharedUtil,
    clearPeriod: clearPeriod,
  );
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier(
    this.sharedUtility, {
    required this.clearPeriod,
  }) : super(sharedUtility.loadTasks());

  final SharedUtility sharedUtility;
  final Period clearPeriod;

  void _saveTasks([List<Task>? tasks]) {
    final tasksToSave = tasks ?? state;
    log('saving tasks: ${tasksToSave.length}');
    sharedUtility.saveTasks(tasksToSave);
  }

  void loadTasks() {
    final List<Task> data = sharedUtility.loadTasks();

    final List<Task> filteredTasks = data
        .where(
          (task) => TasksClearPeriodNotifier.isTaskUnderClearPeriod(
            task,
            clearPeriod,
          ),
        )
        .toList();
    _saveTasks(filteredTasks);

    state = filteredTasks;
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
  void nextTaskStatus(Task task) {
    final updatedTask = _changeTaskStatus(task);
    state = state.map((t) => t.id == updatedTask.id ? updatedTask : t).toList();
    _saveTasks();
  }

  void remove(Task task) {
    state = state.where((t) => t.id != task.id).toList();
    _saveTasks();
  }

  void clear() {
    log('clearing tasks');
    state = [];
    _saveTasks();
  }

  /// Changes task status on [status] if provided, otherwise changes to the next status.
  ///
  /// If next status is [TaskStatus.completed], updates completedAt property.
  Task _changeTaskStatus(Task task, {TaskStatus? status}) {
    final TaskStatus newStatus = status ?? TaskStatus.nextStatus(task.status);

    final updatedTask = task.copyWith(
      status: newStatus,
      isCompleted: newStatus == TaskStatus.completed,
      completedAt: newStatus == TaskStatus.completed ? DateTime.now() : null,
    );
    log('updated task: $updatedTask');

    return updatedTask;
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
              ? _changeTaskStatus(
                  task.copyWith(
                    name: name,
                  ),
                  status: status,
                )
              : task,
        )
        .toList();
    _saveTasks();
  }
}
