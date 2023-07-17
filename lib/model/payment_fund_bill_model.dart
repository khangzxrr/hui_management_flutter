import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/fund_session_model.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_fund_bill_model.g.dart';

@JsonSerializable()
class FundBillModel {
  int id;
  GeneralFundModel fromFund;
  FundSession fromSession;
  NormalSessionDetail fromSessionDetail;

  FundBillModel({required this.id, required this.fromFund, required this.fromSession, required this.fromSessionDetail});

  factory FundBillModel.fromJson(Map<String, dynamic> json) => _$FundBillModelFromJson(json);
  Map<String, dynamic> toJson() => _$FundBillModelToJson(this);
}
