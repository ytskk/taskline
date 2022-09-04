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
  Widget build(BuildContext context) {
    return Scaffold(
      // Hide segmented control if there are no tasks.
      // persistentFooterAlignment: AlignmentDirectional.centerStart,
      // persistentFooterButtons: [
      //   const TasksFilter(),
      // ],
      bottomNavigationBar: const TasksFilter(),
      appBar: AppBar(
        actions: [
          // // Debug buttons.
          IconButton(
            onPressed: () {
              ref.read(sharedUtilityProvider).getPreferencesString();
            },
            icon: Icon(Icons.code),
            tooltip: 'Get string',
          ),
          // IconButton(
          //   onPressed: () {
          //     ref.read(taskListProvider.notifier).clear();
          //   },
          //   icon: Icon(Icons.clear_all),
          //   tooltip: 'Clear all tasks',
          // ),
          // IconButton(
          //   onPressed: () {
          //     ref
          //         .read(taskListProvider.notifier)
          //         .add('task ${ref.read(taskListProvider).length + 1}');
          //   },
          //   icon: Icon(Icons.add),
          //   tooltip: 'Add mock task',
          // ),
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
              return const TasksAdd();
            },
          );
        },
        child: SizedBox.expand(
          child: TaskList(),
        ),
      ),
    );
  }
}
