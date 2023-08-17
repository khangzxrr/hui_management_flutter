import 'package:json_annotation/json_annotation.dart';

part 'fund_report_model.g.dart';

@JsonSerializable()
class FundReportModel {
  String markdown;

  FundReportModel({
    required this.markdown,
  });

  factory FundReportModel.fromJson(Map<String, dynamic> json) => _$FundReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$FundReportModelToJson(this);
}
