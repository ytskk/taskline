import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsTable extends ConsumerWidget {
  const SettingsTable({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title!,
                style: TextStyle(
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ],
      ),
    );
  }
}
