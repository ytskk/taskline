import 'package:flutter/material.dart';
import 'package:taskline/features/features.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return TaskListEmpty();
    }

    return TaskListPopulated(
      tasks: tasks,
    );
  }
}
