import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/utils/utils.dart';

class SettingsClearCompletedTasksPeriod extends ConsumerWidget {
  const SettingsClearCompletedTasksPeriod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsTableRow(
      onTap: () async {
        final Period? period = await showModalBottomSheet<Period>(
          context: context,
          builder: (BuildContext context) {
            return _SettingsClearPeriodBottomSheet();
          },
        );
        if (period != null) {
          ref
              .read(tasksClearPeriodProvider.notifier)
              .setTasksClearPeriod(period);
        }
      },
      title: Text('Clear completed tasks period'),
      subtitle: Text(
        'Will delete completed tasks at next launch',
      ),
      trailing: Text(
        getClearPeriodText(ref.watch(tasksClearPeriodProvider)),
      ),
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
  _SettingsClearPeriodBottomSheet({
    Key? key,
  }) : super(key: key);

  final _clearPeriodListData = [
    Period.never(),
    Period.immediately(),
    Period.day(),
    Period.day(1),
    Period.day(2),
    Period.day(3),
    Period.day(4),
    Period.day(5),
    Period.day(6),
    Period.week(),
    Period.week(2),
    Period.week(3),
    Period.week(4),
    Period.month(),
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
