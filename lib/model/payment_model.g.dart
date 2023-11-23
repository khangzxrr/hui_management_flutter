// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      id: json['id'] as int,
      createAt: DateTime.parse(json['createAt'] as String),
      paymentTransactions: (json['paymentTransactions'] as List<dynamic>)
          .map((e) => PaymentTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      customBills: (json['customBills'] as List<dynamic>)
          .map((e) => CustomBill.fromJson(e as Map<String, dynamic>))
          .toList(),
      fundBills: (json['fundBills'] as List<dynamic>)
          .map((e) => FundBillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCost: (json['totalCost'] as num).toDouble(),
      totalTransactionCost: (json['totalTransactionCost'] as num).toDouble(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createAt': instance.createAt.toIso8601String(),
      'paymentTransactions': instance.paymentTransactions,
      'fundBills': instance.fundBills,
      'customBills': instance.customBills,
      'totalCost': instance.totalCost,
      'totalTransactionCost': instance.totalTransactionCost,
      'status': instance.status,
    };
