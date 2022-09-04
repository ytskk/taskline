import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/utils/utils.dart';

class SettingsClearLine extends StatelessWidget {
  const SettingsClearLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsTableRow(
      title: Text(
        'Clear line',
      ),
      subtitle: Text(
        'Delete all tasks',
      ),
      onTap: () async {
        // await _showWarningDialog(context, ref, theme);
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const _ClearLineTasksDialog();
          },
        );
      },
    );
  }
}

class _ClearLineTasksDialog extends ConsumerWidget {
  const _ClearLineTasksDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clear line?'),
          Text(
            '${pluralize(
              ref.watch(taskListProvider).length,
              TasksPluralMap(),
              wrap: true,
            )} will be deleted. Cannot be undone.',
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.error,
          ),
          onPressed: () {
            ref.read(taskListProvider.notifier).clear();
            Navigator.of(context).pop();
          },
          child: Text('Clear'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
