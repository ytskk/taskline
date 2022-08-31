import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/utils/utils.dart';

class TaskListPopulated extends ConsumerWidget {
  const TaskListPopulated({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        16.0,
        64.0,
        16.0,
        0.0,
      ),
      child: RichText(
        text: TextSpan(
          children: [
            for (int index = 0; index < tasks.length; index++) ...[
              _buildTaskTextSpan(
                context,
                ref,
                tasks.elementAt(index),
              ),
              if (index != tasks.length - 1)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 2.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Color _matchColorByStatus(BuildContext context, TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return Theme.of(context).colorScheme.onBackground;
      case TaskStatus.inProgress:
        return Theme.of(context).colorScheme.primary;
      case TaskStatus.done:
        return Theme.of(context).colorScheme.tertiary;
    }
  }

  TextDecoration? _matchDecorationByStatus(
    BuildContext context,
    TaskStatus status,
  ) {
    switch (status) {
      case TaskStatus.todo:
        return null;
      case TaskStatus.inProgress:
        return null;
      case TaskStatus.done:
        return TextDecoration.lineThrough;
    }
  }

  InlineSpan _buildTaskTextSpan(
    BuildContext context,
    WidgetRef ref,
    Task task,
  ) {
    return TextSpan(
      text: '${task.name}',
      recognizer: TapAndLongPressGestureRecognizer()
        ..onLongPress = () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return TaskEdit(task: task);
            },
          );
        }
        ..onTap = () {
          ref.read(taskListProvider.notifier).nextTaskStatus(task);
        },
      style: TextStyle(
        fontSize: 16.0,
        height: 2.0,
        fontWeight: FontWeight.w500,
        decoration: _matchDecorationByStatus(
          context,
          task.status,
        ),
        color: _matchColorByStatus(
          context,
          task.status,
        ),
      ),
    );
  }
}
