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
      type: $enumDecode(_$NormalSessionDetailTypeEnumMap, json['type']),
      fundMember:
          FundMember.fromJson(json['fundMember'] as Map<String, dynamic>),
      lossCost: (json['lossCost'] as num).toDouble(),
    );

Map<String, dynamic> _$NormalSessionDetailToJson(
        NormalSessionDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'predictedPrice': instance.predictedPrice,
      'fundAmount': instance.fundAmount,
      'lossCost': instance.lossCost,
      'serviceCost': instance.serviceCost,
      'payCost': instance.payCost,
      'type': _$NormalSessionDetailTypeEnumMap[instance.type]!,
      'fundMember': instance.fundMember,
    };

const _$NormalSessionDetailTypeEnumMap = {
  NormalSessionDetailType.alive: 'Alive',
  NormalSessionDetailType.dead: 'Dead',
  NormalSessionDetailType.taken: 'Taken',
  NormalSessionDetailType.emergencyTaken: 'EmergencyTaken',
};
