import 'package:hui_management/model/fund_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_taken_session_detail_model.g.dart';

@JsonSerializable()
class TakenSessionDetail {
  int id;
  FundMember fundMember;
  double predictedPrice;
  double fundAmount;
  double remainPrice;
  double serviceCost;

  TakenSessionDetail({
    required this.id,
    required this.fundMember,
    required this.predictedPrice,
    required this.fundAmount,
    required this.remainPrice,
    required this.serviceCost,
  });

  factory TakenSessionDetail.fromJson(Map<String, dynamic> json) => _$TakenSessionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TakenSessionDetailToJson(this);
}
