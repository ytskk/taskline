import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';

class TaskEdit extends ConsumerStatefulWidget {
  const TaskEdit({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  ConsumerState createState() => _TaskEditState();
}

class _TaskEditState extends ConsumerState<TaskEdit> {
  late final nameController;
  late TaskStatus _status;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.task.name);
    _status = widget.task.status;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      title: TextField(
        controller: nameController,
        autofocus: true,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task Status'),
            const SizedBox(height: 16.0),
            CupertinoSlidingSegmentedControl<TaskStatus>(
              children: {
                for (final status in TaskStatus.values)
                  status: Text(
                    status.name,
                  ),
              },
              groupValue: _status,
              onValueChanged: (newValue) {
                setState(() {
                  _status = newValue!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            primary: theme.colorScheme.error,
          ),
          onPressed: () {
            ref.read(taskListProvider.notifier).remove(widget.task);
            Navigator.of(context).pop();
          },
          child: Text('Delete'),
        ),
        TextButton(
          child: Text('Update'),
          onPressed: () {
            ref.read(taskListProvider.notifier).edit(
                  id: widget.task.id,
                  name: nameController.text,
                  status: _status,
                );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
