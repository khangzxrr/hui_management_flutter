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
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$FundBillModelToJson(FundBillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromFund': instance.fromFund,
      'amount': instance.amount,
      'type': instance.type,
      'status': instance.status,
    };
