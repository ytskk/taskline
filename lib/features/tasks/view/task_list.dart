import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';

class TaskList extends ConsumerWidget {
  const TaskList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(filteredProvider);

    if (tasks.isEmpty) {
      return TaskListEmpty();
    }

    return TaskListPopulated(
      tasks: tasks,
    );
  }
}
