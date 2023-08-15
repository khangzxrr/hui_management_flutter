import 'package:json_annotation/json_annotation.dart';

part 'general_fund_model.g.dart';

@JsonSerializable()
class GeneralFundModel {
  int id;
  String name;

  int newSessionDurationDayCount;
  int takenSessionDeliveryDayCount;

  DateTime openDate;
  double fundPrice;
  double serviceCost;

  int membersCount;
  int sessionsCount;

  GeneralFundModel({
    required this.id,
    required this.name,
    required this.newSessionDurationDayCount,
    required this.takenSessionDeliveryDayCount,
    required this.openDate,
    required this.fundPrice,
    required this.serviceCost,
    required this.membersCount,
    required this.sessionsCount,
  });

  factory GeneralFundModel.fromJson(Map<String, dynamic> json) => _$GeneralFundModelFromJson(json);
  Map<String, dynamic> toJson() => _$GeneralFundModelToJson(this);

  @override
  String toString() {
    return 'GeneralFundModel{id: $id, name: $name, new sesion duration day count: $newSessionDurationDayCount, taken session delivery day count: $takenSessionDeliveryDayCount, openDate: $openDate, fundPrice: $fundPrice, serviceCost: $serviceCost, membersCount: $membersCount, sessionsCount: $sessionsCount}';
  }
}
