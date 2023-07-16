import 'package:json_annotation/json_annotation.dart';

part 'payment_transaction_model.g.dart';

@JsonSerializable()
class PaymentTransaction {
  int id;
  String description;
  double amount;
  DateTime createAt;
  String method;

  PaymentTransaction({required this.id, required this.description, required this.amount, required this.createAt, required this.method});

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) => _$PaymentTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentTransactionToJson(this);
}
