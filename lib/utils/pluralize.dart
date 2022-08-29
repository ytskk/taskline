import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:taskline/utils/utils.dart';

String pluralize(int value, PluralMap pluralMap, {bool wrap = false}) {
  final String plural = Intl.plural(
    value,
    other: pluralMap.other,
    one: pluralMap.one,
    two: pluralMap.two,
    few: pluralMap.few,
    many: pluralMap.many,
  );

  return wrap ? '$value $plural' : plural;
}

@immutable
abstract class PluralMap {
  const PluralMap({
    required this.other,
    this.one,
    this.two,
    this.few,
    this.many,
  });

  final String other;
  final String? one;
  final String? two;
  final String? few;
  final String? many;

  static PluralMap? fromString(String plural) {
    switch (plural.toLowerCase()) {
      case 'day':
        return DayPluralMap();
      case 'tasks':
        return TasksPluralMap();
      default:
        return null;
    }
  }
}

class DayPluralMap extends PluralMap {
  const DayPluralMap({
    super.one = 'day',
    super.two = 'days',
    super.few = 'days',
    super.many = 'days',
    super.other = 'days',
  });
}

class WeekPluralMap extends PluralMap {
  const WeekPluralMap({
    super.one = 'week',
    super.two = 'weeks',
    super.few = 'weeks',
    super.many = 'weeks',
    super.other = 'weeks',
  });
}

class MonthPluralMap extends PluralMap {
  const MonthPluralMap({
    super.one = 'month',
    super.two = 'months',
    super.few = 'months',
    super.many = 'months',
    super.other = 'months',
  });
}

class TasksPluralMap extends PluralMap {
  const TasksPluralMap({
    super.one = 'task',
    super.two = 'tasks',
    super.few = 'tasks',
    super.many = 'tasks',
    super.other = 'tasks',
  });
}
