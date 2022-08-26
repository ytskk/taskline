import 'package:flutter/cupertino.dart';
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
      padding: const EdgeInsets.fromLTRB(
        16.0,
        64.0,
        16.0,
        0.0,
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (int i = 0; i < tasks.length; i += 1) ...[
            TaskItem(
              task: tasks.elementAt(i),
              key: ValueKey(tasks.elementAt(i).id),
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
  }
}
