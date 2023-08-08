import 'package:json_annotation/json_annotation.dart';

part 'general_fund_model.g.dart';

@JsonSerializable()
class GeneralFundModel {
  int id;
  String name;
  String openDateText;
  DateTime openDate;
  double fundPrice;
  double serviceCost;

  int membersCount;
  int sessionsCount;

  GeneralFundModel({
    required this.id,
    required this.name,
    required this.openDateText,
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
    return 'GeneralFundModel{id: $id, name: $name, openDateText: $openDateText, openDate: $openDate, fundPrice: $fundPrice, serviceCost: $serviceCost, membersCount: $membersCount, sessionsCount: $sessionsCount}';
  }
}
