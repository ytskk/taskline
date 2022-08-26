import 'package:flutter/material.dart';
import 'package:taskline/features/features.dart';

class TaskListPopulated extends StatelessWidget {
  const TaskListPopulated({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 64.0,
        horizontal: 16.0,
      ),
      // TODO: Broken hero animation. When first task is created, wrap width is 0.
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (int i = 0; i < tasks.length; i += 1) ...[
            TaskItem(
              task: tasks.reversed.elementAt(i),
            ),
            if (i != tasks.length - 1)
              Container(
                width: 2.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
          ],
        ],
      ),
    );
    ;
  }
}
