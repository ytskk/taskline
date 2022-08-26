import 'package:intl/intl.dart';

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

abstract class PluralMap {
  PluralMap({
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
}

class DaysPluralMap implements PluralMap {
  @override
  String? get one => 'day';

  @override
  String? get two => 'days';

  @override
  String? get few => 'days';

  @override
  String? get many => 'days';

  @override
  String get other => 'days';
}

class TasksPluralMap implements PluralMap {
  @override
  String? get one => 'task';

  @override
  String? get two => 'tasks';

  @override
  String? get few => 'tasks';

  @override
  String? get many => 'tasks';

  @override
  String get other => 'tasks';
}
