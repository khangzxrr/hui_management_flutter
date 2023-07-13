// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_normal_session_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalSessionDetail _$NormalSessionDetailFromJson(Map<String, dynamic> json) =>
    NormalSessionDetail(
      id: json['id'] as int,
      payCost: (json['payCost'] as num).toDouble(),
      fundMember:
          FundMember.fromJson(json['fundMember'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NormalSessionDetailToJson(
        NormalSessionDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payCost': instance.payCost,
      'fundMember': instance.fundMember,
    };
