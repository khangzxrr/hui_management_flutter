import 'package:hui_management/model/fund_member.dart';
import 'package:hui_management/model/fund_session_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_model.g.dart';

@JsonSerializable()
class Fund {
  int id;
  String name;
  String openDateText;
  DateTime openDate;
  double fundPrice;
  double serviceCost;

  int membersCount;
  int sessionsCount;

  List<FundMember> members;
  List<FundSession> sessions;

  Fund({
    required this.id,
    required this.name,
    required this.openDateText,
    required this.openDate,
    required this.fundPrice,
    required this.serviceCost,
    required this.membersCount,
    required this.sessionsCount,
    required this.members,
    required this.sessions,
  });

  factory Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);
  Map<String, dynamic> toJson() => _$FundToJson(this);
}
