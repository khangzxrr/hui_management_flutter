import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/fund_taken_session_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_session_model.g.dart';

@JsonSerializable()
class FundSession {
  int id;
  int sessionNumber;
  DateTime takenDate;

  TakenSessionDetail takenSessionDetail;
  List<NormalSessionDetail> normalSessionDetails;

  FundSession({required this.id, required this.sessionNumber, required this.takenDate, required this.takenSessionDetail, required this.normalSessionDetails});

  factory FundSession.fromJson(Map<String, dynamic> json) => _$FundSessionFromJson(json);
  Map<String, dynamic> toJson() => _$FundSessionToJson(this);
}
