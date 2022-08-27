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
    final colorScheme = Theme.of(context).colorScheme;
    final isTasksListNotEmpty = ref.watch(taskListProvider).isNotEmpty;

    return Scaffold(
      bottomNavigationBar: AnimatedSlide(
        offset: Offset(0, isTasksListNotEmpty ? 0 : 1),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: CupertinoSlidingSegmentedControl(
              children: {
                for (final taskFilter in TaskFilter.values)
                  taskFilter: Text(taskFilter.title),
              },
              groupValue: ref.watch(taskFilterProvider),
              onValueChanged: (TaskFilter? value) {
                ref.read(taskFilterProvider.notifier).update((state) => value!);
              },
            ),
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          // // Debug buttons.
          // IconButton(
          //   onPressed: () {
          //     ref.read(sharedUtilityProvider).getPreferencesString();
          //   },
          //   icon: Icon(Icons.code),
          //   tooltip: 'Get string',
          // ),
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
        // Hide segmented control if there are no tasks.
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              final newTaskId = ref.read(taskListProvider.notifier).getUuid();

              return SafeArea(
                child: SingleChildScrollView(
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
                ),
              );
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
