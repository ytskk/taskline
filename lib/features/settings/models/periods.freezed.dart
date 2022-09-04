// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'periods.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Period _$PeriodFromJson(Map<String, dynamic> json) {
  return _Period.fromJson(json);
}

/// @nodoc
mixin _$Period {
  /// Name to display.
  String get name => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;

  /// Coefficient to multiply value to get actual value.
  ///
  /// For day coefficient is 1, for week - 7, for month - 30.
  ///
  /// Example:
  ///
  /// 12 (value) weeks (coefficient 7) is 12*7 = 84 days.
  @JsonKey(defaultValue: 1)
  int get coefficient => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PeriodCopyWith<Period> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeriodCopyWith<$Res> {
  factory $PeriodCopyWith(Period value, $Res Function(Period) then) =
      _$PeriodCopyWithImpl<$Res>;
  $Res call(
      {String name, int value, @JsonKey(defaultValue: 1) int coefficient});
}

/// @nodoc
class _$PeriodCopyWithImpl<$Res> implements $PeriodCopyWith<$Res> {
  _$PeriodCopyWithImpl(this._value, this._then);

  final Period _value;
  // ignore: unused_field
  final $Res Function(Period) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
    Object? coefficient = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      coefficient: coefficient == freezed
          ? _value.coefficient
          : coefficient // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_PeriodCopyWith<$Res> implements $PeriodCopyWith<$Res> {
  factory _$$_PeriodCopyWith(_$_Period value, $Res Function(_$_Period) then) =
      __$$_PeriodCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name, int value, @JsonKey(defaultValue: 1) int coefficient});
}

/// @nodoc
class __$$_PeriodCopyWithImpl<$Res> extends _$PeriodCopyWithImpl<$Res>
    implements _$$_PeriodCopyWith<$Res> {
  __$$_PeriodCopyWithImpl(_$_Period _value, $Res Function(_$_Period) _then)
      : super(_value, (v) => _then(v as _$_Period));

  @override
  _$_Period get _value => super._value as _$_Period;

  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
    Object? coefficient = freezed,
  }) {
    return _then(_$_Period(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      coefficient: coefficient == freezed
          ? _value.coefficient
          : coefficient // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Period extends _Period {
  const _$_Period(
      {required this.name,
      required this.value,
      @JsonKey(defaultValue: 1) required this.coefficient})
      : super._();

  factory _$_Period.fromJson(Map<String, dynamic> json) =>
      _$$_PeriodFromJson(json);

  /// Name to display.
  @override
  final String name;
  @override
  final int value;

  /// Coefficient to multiply value to get actual value.
  ///
  /// For day coefficient is 1, for week - 7, for month - 30.
  ///
  /// Example:
  ///
  /// 12 (value) weeks (coefficient 7) is 12*7 = 84 days.
  @override
  @JsonKey(defaultValue: 1)
  final int coefficient;

  @override
  String toString() {
    return 'Period(name: $name, value: $value, coefficient: $coefficient)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Period &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality()
                .equals(other.coefficient, coefficient));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(coefficient));

  @JsonKey(ignore: true)
  @override
  _$$_PeriodCopyWith<_$_Period> get copyWith =>
      __$$_PeriodCopyWithImpl<_$_Period>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PeriodToJson(
      this,
    );
  }
}

abstract class _Period extends Period {
  const factory _Period(
      {required final String name,
      required final int value,
      @JsonKey(defaultValue: 1) required final int coefficient}) = _$_Period;
  const _Period._() : super._();

  factory _Period.fromJson(Map<String, dynamic> json) = _$_Period.fromJson;

  @override

  /// Name to display.
  String get name;
  @override
  int get value;
  @override

  /// Coefficient to multiply value to get actual value.
  ///
  /// For day coefficient is 1, for week - 7, for month - 30.
  ///
  /// Example:
  ///
  /// 12 (value) weeks (coefficient 7) is 12*7 = 84 days.
  @JsonKey(defaultValue: 1)
  int get coefficient;
  @override
  @JsonKey(ignore: true)
  _$$_PeriodCopyWith<_$_Period> get copyWith =>
      throw _privateConstructorUsedError;
}
