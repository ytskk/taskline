import 'package:flutter/material.dart';

class SettingsTableRow extends StatelessWidget {
  const SettingsTableRow({
    Key? key,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  Widget? _buildTitleChild(Widget? title, ThemeData theme) {
    if (title != null) {
      return DefaultTextStyle(
        style: theme.textTheme.titleMedium!.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
        ),
        child: title,
      );
    }

    return title;
  }

  Widget? _buildSubtitleChild(Widget? title, ThemeData theme) {
    if (title != null) {
      return DefaultTextStyle(
        style: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.inverseSurface,
        ),
        child: title,
      );
    }

    return title;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: _buildTitleChild(title, theme),
      subtitle: _buildSubtitleChild(subtitle, theme),
      trailing: trailing,
      onTap: onTap,
      selectedColor: theme.colorScheme.primary,
    );
  }
}
