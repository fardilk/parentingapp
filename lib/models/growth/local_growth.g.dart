// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_growth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalGrowth _$LocalGrowthFromJson(Map<String, dynamic> json) => LocalGrowth(
      json['Day'] as int,
      (json['-3 SD'] as num).toDouble(),
      (json['3 SD'] as num).toDouble(),
      (json['-2 SD'] as num).toDouble(),
      (json['2 SD'] as num).toDouble(),
      (json['Median'] as num).toDouble(),
    );

Map<String, dynamic> _$LocalGrowthToJson(LocalGrowth instance) =>
    <String, dynamic>{
      'Day': instance.day,
      '-3 SD': instance.minThresholdHighRisk,
      '3 SD': instance.maxThresholdHighRisk,
      '-2 SD': instance.minThresholdLowRisk,
      '2 SD': instance.maxThresholdLowRisk,
      'Median': instance.normal,
    };

LocalChildGrowth _$LocalChildGrowthFromJson(Map<String, dynamic> json) =>
    LocalChildGrowth(
      json['day'] as int,
      (json['growthValue'] as num).toDouble(),
    );

Map<String, dynamic> _$LocalChildGrowthToJson(LocalChildGrowth instance) =>
    <String, dynamic>{
      'day': instance.day,
      'growthValue': instance.growthValue,
    };
