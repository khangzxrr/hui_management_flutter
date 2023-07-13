// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundSession _$FundSessionFromJson(Map<String, dynamic> json) => FundSession(
      id: json['id'] as int,
      takenDate: DateTime.parse(json['takenDate'] as String),
      fundSessionDetails: (json['fundSessionDetails'] as List<dynamic>)
          .map((e) => FundSessionDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FundSessionToJson(FundSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'takenDate': instance.takenDate.toIso8601String(),
      'fundSessionDetails': instance.fundSessionDetails,
    };
