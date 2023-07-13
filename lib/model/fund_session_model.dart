import 'package:hui_management/model/fund_session_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_session_model.g.dart';

@JsonSerializable()
class FundSession {
  int id;
  DateTime takenDate;

  List<FundSessionDetail> fundSessionDetails;

  FundSession({required this.id, required this.takenDate, required this.fundSessionDetails});

  factory FundSession.fromJson(Map<String, dynamic> json) => _$FundSessionFromJson(json);
  Map<String, dynamic> toJson() => _$FundSessionToJson(this);
}
