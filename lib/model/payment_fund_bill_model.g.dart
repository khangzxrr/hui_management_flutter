// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_fund_bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundBillModel _$FundBillModelFromJson(Map<String, dynamic> json) =>
    FundBillModel(
      id: json['id'] as int,
      fromFund:
          GeneralFundModel.fromJson(json['fromFund'] as Map<String, dynamic>),
      fromSession:
          FundSession.fromJson(json['fromSession'] as Map<String, dynamic>),
      fromSessionDetail: NormalSessionDetail.fromJson(
          json['fromSessionDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FundBillModelToJson(FundBillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromFund': instance.fromFund,
      'fromSession': instance.fromSession,
      'fromSessionDetail': instance.fromSessionDetail,
    };
