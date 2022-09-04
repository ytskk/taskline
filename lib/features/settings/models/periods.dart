import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'periods.g.dart';
part 'periods.freezed.dart';

/// Represents custom period of time.
@freezed
abstract class Period with _$Period {
  const Period._();

  const factory Period({
    /// Name to display.
    required String name,
    required int value,

    /// Coefficient to multiply value to get actual value.
    ///
    /// For day coefficient is 1, for week - 7, for month - 30.
    ///
    /// Example:
    ///
    /// 12 (value) weeks (coefficient 7) is 12*7 = 84 days.
    @JsonKey(defaultValue: 1) required int coefficient,
  }) = _Period;

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);

  factory Period.never() => Period(
        name: 'Never',
        value: -1,
        coefficient: 1,
      );

  factory Period.immediately() => Period(
        name: 'Immediately',
        value: 1,
        coefficient: 0,
      );

  factory Period.day([int days = 1]) => Period(
        name: 'Day',
        value: days,
        coefficient: 1,
      );
  factory Period.week([int weeks = 1]) => Period(
        name: 'Week',
        value: weeks,
        coefficient: 7,
      );

  factory Period.month([int months = 1]) => Period(
        name: 'Month',
        value: months,
        coefficient: 30,
      );

  factory Period.fromString(
    String name,
    int? value,
  ) {
    switch (name.toLowerCase()) {
      case 'day':
        return Period.day(value ?? 1);
      case 'week':
        return Period.week(value ?? 1);
      case 'month':
        return Period.month(value ?? 1);
      case 'never':
        return Period.never();
      case 'immediately':
        return Period.immediately();
      default:
        throw ArgumentError('Unknown period: $name');
    }
  }

  int get inDays {
    log('counting in days: ${value * coefficient}');

    return value * coefficient;
  }
}
