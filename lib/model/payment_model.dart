import 'package:hui_management/model/payment_fund_bill_model.dart';
import 'package:hui_management/model/payment_transaction_model.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel {
  int id;
  UserModel owner;
  DateTime createAt;

  List<PaymentTransaction> paymentTransactions;
  List<FundBillModel> fundBills;

  double totalCost;
  String status;

  PaymentModel({required this.id, required this.owner, required this.createAt, required this.paymentTransactions, required this.fundBills, required this.totalCost, required this.status});

  factory PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
