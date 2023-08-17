// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taken_member_report_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TakenMemberReportViewModel _$TakenMemberReportViewModelFromJson(
        Map<String, dynamic> json) =>
    TakenMemberReportViewModel(
      index: json['index'] as int,
      name: json['name'] as String,
      note: json['note'] as String,
      takenDate: DateTime.parse(json['takenDate'] as String),
    );

Map<String, dynamic> _$TakenMemberReportViewModelToJson(
        TakenMemberReportViewModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'note': instance.note,
      'takenDate': instance.takenDate.toIso8601String(),
    };
