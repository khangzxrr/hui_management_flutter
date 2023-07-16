import 'package:hui_management/model/general_fund_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_fund_bill_model.g.dart';

@JsonSerializable()
class FundBillModel {
  int id;
  GeneralFundModel fromFund;
  double amount;
  String type;
  String status;

  FundBillModel({required this.id, required this.fromFund, required this.amount, required this.type, required this.status});

  factory FundBillModel.fromJson(Map<String, dynamic> json) => _$FundBillModelFromJson(json);
  Map<String, dynamic> toJson() => _$FundBillModelToJson(this);
}
