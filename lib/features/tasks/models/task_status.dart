enum TaskStatus {
  todo('Todo'),
  inProgress('In progress'),
  completed('Completed');

  final String name;

  const TaskStatus(this.name);

  static TaskStatus fromName(String name) {
    return TaskStatus.values.firstWhere(
      (TaskStatus status) => status.name == name,
      orElse: () => TaskStatus.todo,
    );
  }

  /// Returns the next status for the given status.
  ///
  /// Represents machine transitions.
  ///
  /// Status to do -> In progress -> Completed -> to do ...
  static TaskStatus nextStatus(TaskStatus taskStatus) {
    switch (taskStatus) {
      case TaskStatus.todo:
        return TaskStatus.inProgress;
      case TaskStatus.inProgress:
        return TaskStatus.completed;
      case TaskStatus.completed:
        return TaskStatus.todo;
    }
  }
}
