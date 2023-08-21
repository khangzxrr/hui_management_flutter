// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fund _$FundFromJson(Map<String, dynamic> json) => Fund(
      id: json['id'] as int,
      name: json['name'] as String,
      fundType: $enumDecode(_$FundTypeEnumMap, json['fundType']),
      newSessionDurationCount: json['newSessionDurationCount'] as int,
      takenSessionDeliveryCount: json['takenSessionDeliveryCount'] as int,
      newSessionCreateDayOfMonth: json['newSessionCreateDayOfMonth'] as int,
      newSessionCreateHourOfDay:
          DateTime.parse(json['newSessionCreateHourOfDay'] as String),
      openDate: DateTime.parse(json['openDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      fundPrice: (json['fundPrice'] as num).toDouble(),
      serviceCost: (json['serviceCost'] as num).toDouble(),
      membersCount: json['membersCount'] as int,
      sessionsCount: json['sessionsCount'] as int,
      members: (json['members'] as List<dynamic>)
          .map((e) => FundMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => FundSession.fromJson(e as Map<String, dynamic>))
          .toList(),
      newSessionCreateDates: (json['newSessionCreateDates'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$FundToJson(Fund instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fundType': _$FundTypeEnumMap[instance.fundType]!,
      'newSessionDurationCount': instance.newSessionDurationCount,
      'takenSessionDeliveryCount': instance.takenSessionDeliveryCount,
      'newSessionCreateDayOfMonth': instance.newSessionCreateDayOfMonth,
      'newSessionCreateHourOfDay':
          instance.newSessionCreateHourOfDay.toIso8601String(),
      'openDate': instance.openDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'fundPrice': instance.fundPrice,
      'serviceCost': instance.serviceCost,
      'membersCount': instance.membersCount,
      'sessionsCount': instance.sessionsCount,
      'newSessionCreateDates': instance.newSessionCreateDates
          .map((e) => e.toIso8601String())
          .toList(),
      'members': instance.members,
      'sessions': instance.sessions,
    };

const _$FundTypeEnumMap = {
  FundType.dayFund: 'DayFund',
  FundType.monthFund: 'MonthFund',
};
