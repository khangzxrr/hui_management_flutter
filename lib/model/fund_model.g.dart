// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fund _$FundFromJson(Map<String, dynamic> json) => Fund(
      id: json['id'] as int,
      name: json['name'] as String,
      openDateText: json['openDateText'] as String,
      openDate: DateTime.parse(json['openDate'] as String),
      fundPrice: (json['fundPrice'] as num).toDouble(),
      serviceCost: (json['serviceCost'] as num).toDouble(),
      membersCount: json['membersCount'] as int,
      sessionsCount: json['sessionsCount'] as int,
      members: (json['members'] as List<dynamic>).map((e) => FundMember.fromJson(e as Map<String, dynamic>)).toList(),
      sessions: (json['sessions'] as List<dynamic>).map((e) => FundSession.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$FundToJson(Fund instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'openDateText': instance.openDateText,
      'openDate': instance.openDate.toIso8601String(),
      'fundPrice': instance.fundPrice,
      'serviceCost': instance.serviceCost,
      'membersCount': instance.membersCount,
      'sessionsCount': instance.sessionsCount,
      'members': instance.members,
      'sessions': instance.sessions,
    };
