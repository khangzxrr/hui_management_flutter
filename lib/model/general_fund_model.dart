import 'package:json_annotation/json_annotation.dart';

part 'general_fund_model.g.dart';

enum FundType {
  @JsonValue('DayFund')
  dayFund,
  @JsonValue('MonthFund')
  monthFund,
}

@JsonSerializable()
class GeneralFundModel {
  int id;
  String name;
  FundType fundType;

  int newSessionDurationCount;
  int takenSessionDeliveryCount;
  int newSessionCreateDayOfMonth;

  DateTime newSessionCreateHourOfDay;

  DateTime openDate;
  DateTime endDate;

  double fundPrice;
  double serviceCost;

  int membersCount;
  int sessionsCount;

  List<DateTime> newSessionCreateDates;

  GeneralFundModel({
    required this.id,
    required this.name,
    required this.fundType,
    required this.newSessionDurationCount,
    required this.takenSessionDeliveryCount,
    required this.newSessionCreateDayOfMonth,
    required this.newSessionCreateHourOfDay,
    required this.openDate,
    required this.endDate,
    required this.fundPrice,
    required this.serviceCost,
    required this.membersCount,
    required this.sessionsCount,
    required this.newSessionCreateDates,
  });

  factory GeneralFundModel.fromJson(Map<String, dynamic> json) => _$GeneralFundModelFromJson(json);
  Map<String, dynamic> toJson() => _$GeneralFundModelToJson(this);

  @override
  String toString() {
    return 'GeneralFundModel{id: $id, name: $name,  openDate: $openDate, fundPrice: $fundPrice, serviceCost: $serviceCost, membersCount: $membersCount, sessionsCount: $sessionsCount}';
  }
}
