// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_normal_session_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalSessionDetail _$NormalSessionDetailFromJson(Map<String, dynamic> json) =>
    NormalSessionDetail(
      id: json['id'] as int,
      predictedPrice: (json['predictedPrice'] as num).toDouble(),
      fundAmount: (json['fundAmount'] as num).toDouble(),
      serviceCost: (json['serviceCost'] as num).toDouble(),
      payCost: (json['payCost'] as num).toDouble(),
      type: json['type'] as String,
      fundMember:
          FundMember.fromJson(json['fundMember'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NormalSessionDetailToJson(
        NormalSessionDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'predictedPrice': instance.predictedPrice,
      'fundAmount': instance.fundAmount,
      'serviceCost': instance.serviceCost,
      'payCost': instance.payCost,
      'type': instance.type,
      'fundMember': instance.fundMember,
    };
