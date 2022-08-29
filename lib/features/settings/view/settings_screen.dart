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
                  final Period? period = await showModalBottomSheet<Period>(
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
                subtitle: Text(
                  'Will delete completed tasks at next launch.',
                ),
                trailing: Text(
                  getClearPeriodText(ref.watch(tasksClearPeriodProvider)),
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

String getClearPeriodText(Period period) {
  final PluralMap? pluralMapFromString = PluralMap.fromString(period.name);
  if (pluralMapFromString != null) {
    return pluralize(period.value, pluralMapFromString, wrap: true);
  }

  return period.name;
}

class _SettingsClearPeriodBottomSheet extends StatelessWidget {
  const _SettingsClearPeriodBottomSheet({
    Key? key,
  }) : super(key: key);

  final _clearPeriodListData = const [
    const NeverPeriod(),
    const ImmediatelyPeriod(),
    const DaysPeriod(),
    const DaysPeriod(2),
    const DaysPeriod(3),
    const DaysPeriod(4),
    const DaysPeriod(5),
    const DaysPeriod(6),
    const WeekPeriod(),
    const WeekPeriod(2),
    const WeekPeriod(3),
    const MonthPeriod(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _clearPeriodListData.length,
      itemBuilder: (BuildContext context, int index) {
        final Period period = _clearPeriodListData.elementAt(index);
        final String title = getClearPeriodText(period);

        return ListTile(
          title: Text(title),
          onTap: () {
            Navigator.of(context).pop(period);
          },
        );
      },
    );
  }
}
