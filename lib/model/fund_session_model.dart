import 'package:hui_management/model/fund_member.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_session_model.g.dart';

@JsonSerializable()
class FundSession {
  int id;
  int sessionNumber;
  DateTime takenDate;

  List<NormalSessionDetail> normalSessionDetails;

  List<FundMember> getTakenFundMember(bool includeEmergencyTaken) {
    final takenSessions = getTakenSessionDetaills(includeEmergencyTaken);

    return takenSessions.map((ts) => ts.fundMember).toList();
  }

  List<NormalSessionDetail> getTakenSessionDetaills(bool includeEmergencyTaken) {
    if (includeEmergencyTaken) {
      return normalSessionDetails.where((nsd) => nsd.type == NormalSessionDetailType.taken || nsd.type == NormalSessionDetailType.emergencyReceivable || nsd.type == NormalSessionDetailType.emergencyTaken).toList();
    }

    return normalSessionDetails.where((nsd) => nsd.type == NormalSessionDetailType.taken || nsd.type == NormalSessionDetailType.emergencyReceivable).toList();
  }

  FundSession({required this.id, required this.sessionNumber, required this.takenDate, required this.normalSessionDetails});

  factory FundSession.fromJson(Map<String, dynamic> json) => _$FundSessionFromJson(json);
  Map<String, dynamic> toJson() => _$FundSessionToJson(this);
}
