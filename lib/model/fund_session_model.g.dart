// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundSession _$FundSessionFromJson(Map<String, dynamic> json) => FundSession(
      id: json['id'] as int,
      sessionNumber: json['sessionNumber'] as int,
      takenDate: DateTime.parse(json['takenDate'] + 'Z' as String),
      normalSessionDetails: (json['normalSessionDetails'] as List<dynamic>).map((e) => NormalSessionDetail.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$FundSessionToJson(FundSession instance) => <String, dynamic>{
      'id': instance.id,
      'sessionNumber': instance.sessionNumber,
      'takenDate': instance.takenDate.toIso8601String(),
      'normalSessionDetails': instance.normalSessionDetails,
    };
