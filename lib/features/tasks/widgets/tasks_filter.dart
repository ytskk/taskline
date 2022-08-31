import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';

class TasksFilter extends ConsumerWidget {
  const TasksFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTasksListNotEmpty = ref.watch(taskListProvider).isNotEmpty;

    return AnimatedSlide(
      offset: Offset(0, isTasksListNotEmpty ? 0 : 1),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
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
    );
  }
}
