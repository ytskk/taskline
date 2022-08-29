import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/utils/utils.dart';
import 'package:taskline/shared/shared.dart';

class SettingsThemeTableGroup extends ConsumerWidget {
  const SettingsThemeTableGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SettingsTable(
      title: 'Theme',
      children: [
        for (final themeMode in ThemeMode.values)
          SettingsTableRow(
            title: Text(themeMode.name.capitalize()),
            onTap: () {
              ref.read(themeModeProvider.notifier).setThemeMode(themeMode);
            },
            trailing: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
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
    );
  }
}
