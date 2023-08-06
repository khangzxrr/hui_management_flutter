import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/user_report_model.dart';

class SingleMemberReport extends StatelessWidget {
  final UserReportModel userReportModel;

  const SingleMemberReport({super.key, required this.userReportModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${userReportModel.name} (${userReportModel.nickName})'),
        subtitle: Text('SĐT ${userReportModel.phoneNumber}'),
        trailing: Text(
            'Âm/dương: ${Utils.moneyFormat.format(userReportModel.fundRatio)}đ'),
        onTap: () {
          //context.router.push(MemberReportRoute(userReportModel: userReportModel));
        },
      ),
    );
  }
}

@RoutePage()
class MemberReportScreen extends StatefulWidget {
  final List<UserReportModel> userReportModels;

  const MemberReportScreen({super.key, required this.userReportModels});

  @override
  State<MemberReportScreen> createState() => _MemberReportScreenState();
}

class _MemberReportScreenState extends State<MemberReportScreen> {
  String filterText = '';

  @override
  Widget build(BuildContext context) {
    final memberReportWidgets = widget.userReportModels
        .where((element) => element
            .toString()
            .toLowerCase()
            .replaceAll(' ', '')
            .contains(filterText.toLowerCase()))
        .map((e) => SingleMemberReport(userReportModel: e))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo thành viên'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tìm kiếm thành viên (tên, sđt, cmnd, địa chỉ, ....))',
            ),
            onChanged: (text) {
              setState(() {
                filterText = text;
              });
            },
          ),
          ...memberReportWidgets,
        ],
      ),
    );
  }
}
