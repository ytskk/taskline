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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
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
                    const SizedBox(height: 32.0),
                    _TaskEditStatusToggle(
                      values: TaskStatus.values.map((e) => e.name).toList(),
                      statusIndex: _status.index,
                      onPressed: (index) {
                        setState(() {
                          _status = TaskStatus.values.elementAt(index);
                        });
                      },
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

class _TaskEditStatusToggle extends StatelessWidget {
  const _TaskEditStatusToggle({
    Key? key,
    required this.values,
    required this.statusIndex,
    this.onPressed,
  }) : super(key: key);

  final int statusIndex;
  final List values;
  final ValueChanged<int>? onPressed;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: onPressed,
      // constraints: BoxConstraints(
      //   /// 28 - magic number to fit all buttons
      //   minWidth: (MediaQuery.of(context).size.width - 28.0) / 3,
      //   maxWidth: 300.0,
      //   minHeight: 44.0,
      // ),
      children: _generateToggleButtonList(values),
      isSelected: _generateSelectedList(values, statusIndex),
    );
  }

  List<bool> _generateSelectedList(List list, int index) {
    return List.generate(list.length, (i) => i == index);
  }

  List<Widget> _generateToggleButtonList(List list) {
    return List.generate(list.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          list.elementAt(index),
        ),
      );
    });
  }
}
