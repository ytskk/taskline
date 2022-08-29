// TODO: periods. Day, week, month, Never, Instantly?.

import 'dart:developer';

import 'package:flutter/widgets.dart';

@immutable
abstract class Period {
  /// Name to display.
  final String name;

  /// Represents value to display.
  final int value;

  /// Coefficient to multiply value to get actual value.
  ///
  /// For day coefficient is 1, for week - 7, for month - 30.
  ///
  /// 12 (value) weeks (coefficient 7) is 12*7 = 84 days.
  final int coefficient;

  const Period({
    required this.name,
    required this.value,
    required this.coefficient,
  });

  int get inDays {
    log('counting in days: ${value * coefficient}');

    return value * coefficient;
  }

  @override
  String toString() => '$runtimeType($name, $value, $coefficient)';

  // from json
  factory Period.fromJson(Map<String, dynamic> json) {
    log('acceptiong json: $json');
    final jsonMap = {
      'name': json['name'] as String,
      'value': json['value'] as int?,
    };

    return Period.fromString(
      jsonMap['name'] as String,
      jsonMap['value'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
      };

  factory Period.fromString(
    String name,
    int? value,
  ) {
    switch (name.toLowerCase()) {
      case 'day':
        return DaysPeriod(value ?? 1);
      case 'week':
        return WeekPeriod(value ?? 1);
      case 'month':
        return MonthPeriod(value ?? 1);
      case 'never':
        return NeverPeriod();
      case 'immediately':
        return ImmediatelyPeriod();
      default:
        throw ArgumentError('Unknown period: $name');
    }
  }
}

class NeverPeriod extends Period {
  const NeverPeriod()
      : super(
          name: 'Never',
          value: -1,
          coefficient: 1,
        );
}

class ImmediatelyPeriod extends Period {
  const ImmediatelyPeriod()
      : super(
          name: 'Immediately',
          value: 0,
          coefficient: 1,
        );
}

class DaysPeriod extends Period {
  const DaysPeriod([int value = 1])
      : super(
          name: 'Day',
          value: value,
          coefficient: 1,
        );
}

class WeekPeriod extends Period {
  const WeekPeriod([int value = 1])
      : super(
          name: 'Week',
          value: value,
          coefficient: 7,
        );
}

class MonthPeriod extends Period {
  const MonthPeriod([int value = 1])
      : super(
          name: 'Month',
          value: value,
          coefficient: 30,
        );
}
