// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTransaction _$PaymentTransactionFromJson(Map<String, dynamic> json) =>
    PaymentTransaction(
      id: json['id'] as int,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      createAt: DateTime.parse(json['createAt'] as String),
      method: json['method'] as String,
    );

Map<String, dynamic> _$PaymentTransactionToJson(PaymentTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'amount': instance.amount,
      'createAt': instance.createAt.toIso8601String(),
      'method': instance.method,
    };
