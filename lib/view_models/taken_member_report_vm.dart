import 'package:json_annotation/json_annotation.dart';

part 'taken_member_report_vm.g.dart';

@JsonSerializable()
class TakenMemberReportViewModel {
  int index;
  String name;
  String note;
  DateTime takenDate;

  TakenMemberReportViewModel({
    required this.index,
    required this.name,
    required this.note,
    required this.takenDate,
  });

  factory TakenMemberReportViewModel.fromJson(Map<String, dynamic> json) => _$TakenMemberReportViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$TakenMemberReportViewModelToJson(this);
}
