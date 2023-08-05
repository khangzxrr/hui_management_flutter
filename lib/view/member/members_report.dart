import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/model/user_report_model.dart';

class SingleMemberReport extends StatelessWidget {

  final UserReportModel userReportModel;

  const SingleMemberReport({super.key, required this.userReportModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${userReportModel.name} (${userReportModel.nickName})'),
        subtitle: Text('SĐT ${userReportModel.phonenumber}'),
        trailing: Text(userReportModel.name),
        onTap: () {
          //context.router.push(MemberReportRoute(userReportModel: userReportModel));
        },
      ),
    );
  }
}

@RoutePage()
class MemberReportScreen extends StatelessWidget {
  final List<UserReportModel> userReportModels;

  const MemberReportScreen({super.key, required this.userReportModels});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: userReportModels.map((e) => SingleMemberReport(userReportModel: e)).toList(),
    );
  }
}
