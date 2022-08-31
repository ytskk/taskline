import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar.large(
              title: Text('Settings'),
            ),
          ];
        },
        body: ListView(
          children: [
            const SettingsThemeTableGroup(),
            const SettingsTasksTableGroup(),
            const SettingsAboutTableGroup(),
            const SettingsDevelopmentTableGroup(),
          ],
        ),
      ),
    );
  }
}
