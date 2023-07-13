// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_session_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundSessionDetail _$FundSessionDetailFromJson(Map<String, dynamic> json) =>
    FundSessionDetail(
      id: json['id'] as int,
      fundMember:
          FundMember.fromJson(json['fundMember'] as Map<String, dynamic>),
      predictedPrice: (json['predictedPrice'] as num).toDouble(),
      fundAmount: (json['fundAmount'] as num).toDouble(),
      remainPrice: (json['remainPrice'] as num).toDouble(),
      serviceCost: (json['serviceCost'] as num).toDouble(),
      isTaken: json['isTaken'] as bool,
    );

Map<String, dynamic> _$FundSessionDetailToJson(FundSessionDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fundMember': instance.fundMember,
      'predictedPrice': instance.predictedPrice,
      'fundAmount': instance.fundAmount,
      'remainPrice': instance.remainPrice,
      'serviceCost': instance.serviceCost,
      'isTaken': instance.isTaken,
    };
