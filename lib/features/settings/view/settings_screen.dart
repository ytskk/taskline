import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/shared/shared.dart';
import 'package:taskline/utils/utils.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SettingsTable(
            title: 'Theme',
            children: [
              for (final themeMode in ThemeMode.values)
                SettingsTableRow(
                  title: Text(themeMode.name.capitalize()),
                  onTap: () {
                    ref
                        .read(themeModeProvider.notifier)
                        .setThemeMode(themeMode);
                  },
                  trailing: Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final ThemeMode selectedThemeMode =
                          ref.watch(themeModeProvider);
                      final bool isSelected = themeMode == selectedThemeMode;

                      return AnimatedCrossFade(
                        alignment: Alignment.center,
                        crossFadeState: isSelected
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 300),
                        firstChild: Icon(
                          Icons.check,
                          color: theme.colorScheme.primary,
                        ),
                        secondChild: SizedBox.shrink(),
                      );
                    },
                  ),
                ),
            ],
          ),
          SettingsTable(
            title: 'Tasks',
            children: [
              SettingsTableRow(
                title: Text(
                  'Clear line',
                ),
                subtitle: Text(
                  'Delete all tasks',
                ),
                onTap: () async {
                  await _showWarningDialog(context, ref, theme);
                },
              ),
              SettingsTableRow(
                onTap: () async {
                  final int? period = await showModalBottomSheet<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return _SettingsClearPeriodBottomSheet();
                    },
                  );
                  log('period: $period');
                  if (period != null) {
                    ref
                        .read(tasksClearPeriodProvider.notifier)
                        .setTasksClearPeriod(period);
                  }
                },
                title: Text('Clear completed tasks period'),
                trailing: Text(
                  pluralize(
                    ref.watch(tasksClearPeriodProvider),
                    DaysPluralMap(),
                    wrap: true,
                  ),
                ),
              ),
            ],
          ),
          SettingsTable(
            children: [
              SettingsTableRow(
                title: Text(
                  'About',
                ),
                onTap: () {
                  // push about screen
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) {
                        return const AboutScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          SettingsTable(
            title: 'Development',
            children: [
              SettingsTableRow(
                title: Text('Colors'),
                subtitle: Text(
                  'List of Material 3 generated color palettes.',
                ),
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) {
                        return const TestThemeScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _showWarningDialog(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
  ) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
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
                primary: theme.colorScheme.error,
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
      },
    );
  }
}

class _SettingsClearPeriodBottomSheet extends StatelessWidget {
  const _SettingsClearPeriodBottomSheet({
    Key? key,
  }) : super(key: key);

  final _clearPeriodListData = const [
    {
      'name': 'Never',
      'value': -1,
    },
    {
      'name': '0 days',
      'value': 0,
    },
    {
      'name': '1 day',
      'value': 1,
    },
    {
      'name': '2 days',
      'value': 2,
    },
    {
      'name': '3 days',
      'value': 3,
    },
    {
      'name': '4 days',
      'value': 4,
    },
    {
      'name': '5 days',
      'value': 5,
    },
    {
      'name': '6 days',
      'value': 6,
    },
    {
      'name': '1 week',
      'value': 7,
    },
    {
      'name': '2 weeks',
      'value': 14,
    },
    {
      'name': '1 month',
      'value': 30,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _clearPeriodListData.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_clearPeriodListData[index]['name'].toString()),
          onTap: () {
            Navigator.of(context).pop(_clearPeriodListData[index]['value']);
          },
        );
      },
    );
  }
}
