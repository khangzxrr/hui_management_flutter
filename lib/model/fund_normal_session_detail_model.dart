import 'package:hui_management/model/fund_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_normal_session_detail_model.g.dart';

@JsonSerializable()
class NormalSessionDetail {
  int id;
  double payCost;
  FundMember fundMember;

  NormalSessionDetail({required this.id, required this.payCost, required this.fundMember});

  factory NormalSessionDetail.fromJson(Map<String, dynamic> json) => _$NormalSessionDetailFromJson(json);
  Map<String, dynamic> toJson() => _$NormalSessionDetailToJson(this);
}
