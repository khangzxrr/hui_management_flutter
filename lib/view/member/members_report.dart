import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/model/user_report_model.dart';

@RoutePage()
class MemberReportScreen extends StatelessWidget {
  final List<UserReportModel> userReportModels;

  const MemberReportScreen({super.key, required this.userReportModels});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
