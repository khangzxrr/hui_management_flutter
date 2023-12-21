import 'package:hui_management/model/fund_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_normal_session_detail_model.g.dart';

enum NormalSessionDetailType {
  @JsonValue('Alive')
  alive,
  @JsonValue('Dead')
  dead,
  @JsonValue('Taken')
  taken,
  @JsonValue('EmergencyTaken')
  emergencyTaken
}

@JsonSerializable()
class NormalSessionDetail {
  int id;

  double predictedPrice;
  double fundAmount;
  double lossCost;
  double serviceCost;

  double payCost;
  NormalSessionDetailType type;
  FundMember fundMember;

  NormalSessionDetail({required this.id, required this.predictedPrice, required this.fundAmount, required this.serviceCost, required this.payCost, required this.type, required this.fundMember, required this.lossCost});

  factory NormalSessionDetail.fromJson(Map<String, dynamic> json) => _$NormalSessionDetailFromJson(json);
  Map<String, dynamic> toJson() => _$NormalSessionDetailToJson(this);
}
