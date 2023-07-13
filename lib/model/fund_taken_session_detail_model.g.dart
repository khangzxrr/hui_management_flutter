// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_taken_session_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TakenSessionDetail _$TakenSessionDetailFromJson(Map<String, dynamic> json) =>
    TakenSessionDetail(
      id: json['id'] as int,
      fundMember:
          FundMember.fromJson(json['fundMember'] as Map<String, dynamic>),
      predictedPrice: (json['predictedPrice'] as num).toDouble(),
      fundAmount: (json['fundAmount'] as num).toDouble(),
      remainPrice: (json['remainPrice'] as num).toDouble(),
      serviceCost: (json['serviceCost'] as num).toDouble(),
    );

Map<String, dynamic> _$TakenSessionDetailToJson(TakenSessionDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fundMember': instance.fundMember,
      'predictedPrice': instance.predictedPrice,
      'fundAmount': instance.fundAmount,
      'remainPrice': instance.remainPrice,
      'serviceCost': instance.serviceCost,
    };
