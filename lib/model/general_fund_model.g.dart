// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_fund_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralFundModel _$GeneralFundModelFromJson(Map<String, dynamic> json) =>
    GeneralFundModel(
      id: json['id'] as int,
      name: json['name'] as String,
      fundType: $enumDecode(_$FundTypeEnumMap, json['fundType']),
      newSessionDurationCount: json['newSessionDurationCount'] as int,
      takenSessionDeliveryCount: json['takenSessionDeliveryCount'] as int,
      newSessionCreateDayOfMonth: json['newSessionCreateDayOfMonth'] as int,
      newSessionCreateHourOfDay:
          DateTime.parse(json['newSessionCreateHourOfDay'] as String),
      takenSessionDeliveryHourOfDay:
          DateTime.parse(json['takenSessionDeliveryHourOfDay'] as String),
      openDate: DateTime.parse(json['openDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      fundPrice: (json['fundPrice'] as num).toDouble(),
      serviceCost: (json['serviceCost'] as num).toDouble(),
      membersCount: json['membersCount'] as int,
      sessionsCount: json['sessionsCount'] as int,
      emergencySessionsCount: json['emergencySessionsCount'] as int,
      newSessionCreateDates: (json['newSessionCreateDates'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$GeneralFundModelToJson(GeneralFundModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fundType': _$FundTypeEnumMap[instance.fundType]!,
      'newSessionDurationCount': instance.newSessionDurationCount,
      'takenSessionDeliveryCount': instance.takenSessionDeliveryCount,
      'newSessionCreateDayOfMonth': instance.newSessionCreateDayOfMonth,
      'newSessionCreateHourOfDay':
          instance.newSessionCreateHourOfDay.toIso8601String(),
      'takenSessionDeliveryHourOfDay':
          instance.takenSessionDeliveryHourOfDay.toIso8601String(),
      'openDate': instance.openDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'fundPrice': instance.fundPrice,
      'serviceCost': instance.serviceCost,
      'membersCount': instance.membersCount,
      'sessionsCount': instance.sessionsCount,
      'emergencySessionsCount': instance.emergencySessionsCount,
      'newSessionCreateDates': instance.newSessionCreateDates
          .map((e) => e.toIso8601String())
          .toList(),
    };

const _$FundTypeEnumMap = {
  FundType.dayFund: 'DayFund',
  FundType.monthFund: 'MonthFund',
};
