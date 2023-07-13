import 'package:hui_management/model/fund_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_session_detail_model.g.dart';

@JsonSerializable()
class FundSessionDetail {
  int id;
  FundMember fundMember;
  double predictedPrice;
  double fundAmount;
  double remainPrice;
  double serviceCost;
  bool isTaken;

  FundSessionDetail({
    required this.id,
    required this.fundMember,
    required this.predictedPrice,
    required this.fundAmount,
    required this.remainPrice,
    required this.serviceCost,
    required this.isTaken,
  });

  factory FundSessionDetail.fromJson(Map<String, dynamic> json) => _$FundSessionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$FundSessionDetailToJson(this);
}
