// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_fund_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralFundModel _$GeneralFundModelFromJson(Map<String, dynamic> json) =>
    GeneralFundModel(
      id: json['id'] as int,
      name: json['name'] as String,
      openDateText: json['openDateText'] as String,
      openDate: DateTime.parse(json['openDate'] as String),
      fundPrice: (json['fundPrice'] as num).toDouble(),
      serviceCost: (json['serviceCost'] as num).toDouble(),
      membersCount: json['membersCount'] as int,
      sessionsCount: json['sessionsCount'] as int,
    );

Map<String, dynamic> _$GeneralFundModelToJson(GeneralFundModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'openDateText': instance.openDateText,
      'openDate': instance.openDate.toIso8601String(),
      'fundPrice': instance.fundPrice,
      'serviceCost': instance.serviceCost,
      'membersCount': instance.membersCount,
      'sessionsCount': instance.sessionsCount,
    };
