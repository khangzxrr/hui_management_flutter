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

  Fund({
    required this.id,
    required this.name,
    required this.openDateText,
    required this.openDate,
    required this.fundPrice,
    required this.serviceCost,
    required this.membersCount,
    required this.sessionsCount,
  });

  factory Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);
  Map<String, dynamic> toJson() => _$FundToJson(this);
}
