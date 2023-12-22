import 'package:hui_management/model/fund_member.dart';
import 'package:hui_management/model/fund_session_model.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_model.g.dart';

@JsonSerializable()
class Fund extends GeneralFundModel {
  List<FundMember> members;
  List<FundSession> sessions;

  Fund({
    required super.id,
    required super.name,
    required super.fundType,
    required super.newSessionDurationCount,
    required super.takenSessionDeliveryCount,
    required super.newSessionCreateDayOfMonth,
    required super.newSessionCreateHourOfDay,
    required super.takenSessionDeliveryHourOfDay,
    required super.openDate,
    required super.endDate,
    required super.fundPrice,
    required super.serviceCost,
    required super.membersCount,
    required super.sessionsCount,
    required super.emergencySessionsCount,
    required this.members,
    required this.sessions,
    required super.newSessionCreateDates,
  });

  factory Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FundToJson(this);
}
