import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:taskline/features/features.dart';

class TasksAdd extends ConsumerStatefulWidget {
  const TasksAdd({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasksAddState();
}

class _TasksAddState extends ConsumerState<TasksAdd> {
  late final TextEditingController _taskNameController;

  @override
  void initState() {
    super.initState();

    _taskNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
            left: 12.0,
            right: 12.0,
          ),
          child: TextFormField(
            controller: _taskNameController,
            decoration: InputDecoration(
              hintText: 'New task name',
            ),
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.sentences,
            textAlign: TextAlign.center,
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: (_) =>
                _createTask(context, _taskNameController.text),
          ),
        ),
      ),
    );
  }

  void _createTask(BuildContext context, String name) {
    if (name.isNotEmpty) {
      ref.read(taskListProvider.notifier).add(
            name,
          );
    }

    Navigator.of(context).pop();
  }
}
