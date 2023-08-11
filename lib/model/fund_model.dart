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
    required super.openDateText,
    required super.openDate,
    required super.fundPrice,
    required super.serviceCost,
    required super.membersCount,
    required super.sessionsCount,
    required this.members,
    required this.sessions,
  });

  factory Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);
  Map<String, dynamic> toJson() => _$FundToJson(this);
}
