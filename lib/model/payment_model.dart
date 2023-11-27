import 'package:hui_management/model/payment_fund_bill_model.dart';
import 'package:hui_management/model/payment_transaction_model.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'custom_bill_model.dart';

part 'payment_model.g.dart';

enum PaymentStatus {
  @JsonValue("Processing")
  processing,
  @JsonValue("Debting")
  debting,
  @JsonValue("Finish")
  finish
}

@JsonSerializable()
class PaymentModel {
  int id;
  DateTime createAt;

  SubUserModel owner;

  List<PaymentTransaction> paymentTransactions;
  List<FundBillModel> fundBills;

  List<CustomBill> customBills;

  double totalCost;
  double totalTransactionCost;
  double totalOwnerMustPaid;
  double totalOwnerMustTake;
  double ownerPaidTakeDiff;
  double remainPayCost;

  PaymentStatus status;

  PaymentModel({
    required this.id,
    required this.createAt,
    required this.owner,
    required this.paymentTransactions,
    required this.customBills,
    required this.fundBills,
    required this.totalCost,
    required this.totalTransactionCost,
    required this.remainPayCost,
    required this.totalOwnerMustPaid,
    required this.totalOwnerMustTake,
    required this.ownerPaidTakeDiff,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
