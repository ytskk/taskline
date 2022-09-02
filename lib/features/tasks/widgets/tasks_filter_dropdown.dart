import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';

class TasksFilterDropdown extends ConsumerWidget {
  const TasksFilterDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: theme.colorScheme.surfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      onPressed: () async {
        final TaskFilter? filterOption =
            await _showFilterTypeSelectionDialog(context);

        log('filterOption: $filterOption');

        if (filterOption != null) {
          ref.read(taskFilterProvider.notifier).update((state) => filterOption);
        }
      },
      child: Text(
        ref.watch(taskFilterProvider).title,
        style: theme.textTheme.titleMedium!.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  List<TaskFilter> _generateFilterItems() {
    return TaskFilter.values;
  }

  List<Widget> _wrapFilterItemsWithIos(
    BuildContext context,
    List<TaskFilter> items,
  ) {
    return items
        .map(
          (item) => CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop(item);
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  item.title,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _wrapFilterItemsWithMaterial(
    BuildContext context,
    List<TaskFilter> items,
  ) {
    return ListTile.divideTiles(
      tiles: items.map(
        (item) => ListTile(
          title: Text(item.title),
          onTap: () {
            Navigator.of(context).pop(item);
          },
        ),
      ),
      context: context,
    ).toList();
  }

  Future<TaskFilter?> _showFilterTypeSelectionDialog(
    BuildContext context,
  ) async {
    final List<TaskFilter> items = _generateFilterItems();

    if (Platform.isIOS) {
      return await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: _wrapFilterItemsWithIos(context, items),
            cancelButton: CupertinoActionSheetAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        },
      );
    }

    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return MaterialPopover(
          items: _wrapFilterItemsWithMaterial(context, items),
        );
      },
    );
  }
}

class MaterialPopover extends StatelessWidget {
  const MaterialPopover({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 24.0,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...items,
          ],
        ),
      ),
    );
  }
}
