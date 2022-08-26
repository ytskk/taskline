enum TaskStatus {
  todo('TODO'),
  inProgress('In progress'),
  done('Done');

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
  /// Status to do -> In progress -> Done -> to do ...
  static TaskStatus nextStatus(TaskStatus taskStatus) {
    switch (taskStatus) {
      case TaskStatus.todo:
        return TaskStatus.inProgress;
      case TaskStatus.inProgress:
        return TaskStatus.done;
      case TaskStatus.done:
        return TaskStatus.todo;
    }
  }
}
