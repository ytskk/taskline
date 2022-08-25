import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/shared/shared.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(taskListProvider.notifier).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final List<Task> tasks = ref.watch(taskListProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(taskListProvider.notifier).clear();
            },
            icon: Icon(Icons.clear_all),
            tooltip: 'Clear all tasks',
          ),
          IconButton(
            onPressed: () {
              ref
                  .read(taskListProvider.notifier)
                  .add('task ${tasks.length + 1}');
            },
            icon: Icon(Icons.add),
            tooltip: 'Add mock task',
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return const SettingsScreen();
                  },
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              final newTaskId = ref.read(taskListProvider.notifier).getUuid();

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 16,
                    right: 16,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        textAlign: TextAlign.center,
                        autofocus: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onFieldSubmitted: (String value) {
                          if (value.isNotEmpty) {
                            ref.read(taskListProvider.notifier).add(
                                  value,
                                  taskId: newTaskId,
                                );
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                      Opacity(
                        opacity: 0,
                        child: Hero(
                          tag: 'task-$newTaskId',
                          child: Text(
                            '$newTaskId',
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: SizedBox.expand(
          child: TaskList(
            tasks: tasks,
          ),
        ),
      ),
    );
  }
}
