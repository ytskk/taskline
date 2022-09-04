// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Period _$$_PeriodFromJson(Map<String, dynamic> json) => _$_Period(
      name: json['name'] as String,
      value: json['value'] as int,
      coefficient: json['coefficient'] as int? ?? 1,
    );

Map<String, dynamic> _$$_PeriodToJson(_$_Period instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'coefficient': instance.coefficient,
    };
