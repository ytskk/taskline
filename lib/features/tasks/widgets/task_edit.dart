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

    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: theme.colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.error,
                          ),
                          onPressed: () {
                            ref
                                .read(taskListProvider.notifier)
                                .remove(widget.task);
                            Navigator.of(context).pop();
                          },
                          child: Text('Delete'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.primary,
                          ),
                          onPressed: () {
                            ref.read(taskListProvider.notifier).edit(
                                  id: widget.task.id,
                                  name: nameController.text,
                                  status: _status,
                                );
                            Navigator.of(context).pop();
                          },
                          child: Text('Update'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 16.0),
                    Text('Task Status'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoSlidingSegmentedControl<TaskStatus>(
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
