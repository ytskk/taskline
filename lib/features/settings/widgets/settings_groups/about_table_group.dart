import 'package:flutter/cupertino.dart';
import 'package:taskline/features/features.dart';

class SettingsAboutTableGroup extends StatelessWidget {
  const SettingsAboutTableGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsTable(
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
    );
  }
}
