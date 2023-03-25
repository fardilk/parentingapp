import 'package:json_annotation/json_annotation.dart';

part 'local_growth.g.dart';

@JsonSerializable()
class LocalGrowth {
  @JsonKey(name: 'Day')
  final int day;
  @JsonKey(name: '-3 SD')
  final double minThresholdHighRisk;
  @JsonKey(name: '3 SD')
  final double maxThresholdHighRisk;
  @JsonKey(name: '-2 SD')
  final double minThresholdLowRisk;
  @JsonKey(name: '2 SD')
  final double maxThresholdLowRisk;
  @JsonKey(name: 'Median')
  final double normal;

  LocalGrowth(this.day, this.minThresholdHighRisk, this.maxThresholdHighRisk,
      this.minThresholdLowRisk, this.maxThresholdLowRisk, this.normal);

  factory LocalGrowth.fromJson(Map<String, dynamic> json) =>
      _$LocalGrowthFromJson(json);

  Map<String, dynamic> toJson() => _$LocalGrowthToJson(this);
}

@JsonSerializable()
class LocalChildGrowth {
  final int day;
  final double growthValue;

  LocalChildGrowth(this.day, this.growthValue);
}
