import 'package:flutter/cupertino.dart';
import 'package:taskline/features/features.dart';

class SettingsDevelopmentTableGroup extends StatelessWidget {
  const SettingsDevelopmentTableGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsTable(
      title: 'Development',
      children: [
        SettingsTableRow(
          title: Text('Colors'),
          subtitle: Text(
            'List of theme-based dynamic generated color palettes',
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
    );
  }
}
