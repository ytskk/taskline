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
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
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
                          ref.watch(themeModeProvider).loadThemeMode();
                      final bool isSelected = themeMode == selectedThemeMode;

                      return Icon(
                        isSelected ? Icons.check : null,
                        color: isSelected ? theme.colorScheme.primary : null,
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
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: theme.colorScheme.surface,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Clear line?'),
                            Text(
                              'This will delete all tasks. Cannot be undone.',
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
                  ref.read(taskListProvider.notifier).clear();
                },
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
}
