// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_fund_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralFundModel _$GeneralFundModelFromJson(Map<String, dynamic> json) =>
    GeneralFundModel(
      id: json['id'] as int,
      name: json['name'] as String,
      newSessionDurationDayCount: json['newSessionDurationDayCount'] as int,
      currentSessionDurationDate:
          DateTime.parse(json['currentSessionDurationDate'] as String),
      nextSessionDurationDate:
          DateTime.parse(json['nextSessionDurationDate'] as String),
      takenSessionDeliveryDayCount: json['takenSessionDeliveryDayCount'] as int,
      currentTakenSessionDeliveryDate:
          DateTime.parse(json['currentTakenSessionDeliveryDate'] as String),
      nextTakenSessionDeliveryDate:
          DateTime.parse(json['nextTakenSessionDeliveryDate'] as String),
      openDate: DateTime.parse(json['openDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      fundPrice: (json['fundPrice'] as num).toDouble(),
      serviceCost: (json['serviceCost'] as num).toDouble(),
      lastSessionFundPrice: (json['lastSessionFundPrice'] as num).toDouble(),
      membersCount: json['membersCount'] as int,
      sessionsCount: json['sessionsCount'] as int,
    );

Map<String, dynamic> _$GeneralFundModelToJson(GeneralFundModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'newSessionDurationDayCount': instance.newSessionDurationDayCount,
      'currentSessionDurationDate':
          instance.currentSessionDurationDate.toIso8601String(),
      'nextSessionDurationDate':
          instance.nextSessionDurationDate.toIso8601String(),
      'takenSessionDeliveryDayCount': instance.takenSessionDeliveryDayCount,
      'currentTakenSessionDeliveryDate':
          instance.currentTakenSessionDeliveryDate.toIso8601String(),
      'nextTakenSessionDeliveryDate':
          instance.nextTakenSessionDeliveryDate.toIso8601String(),
      'openDate': instance.openDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'fundPrice': instance.fundPrice,
      'serviceCost': instance.serviceCost,
      'lastSessionFundPrice': instance.lastSessionFundPrice,
      'membersCount': instance.membersCount,
      'sessionsCount': instance.sessionsCount,
    };
