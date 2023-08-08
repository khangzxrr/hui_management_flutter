import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/model/user_report_model.dart';
import 'package:hui_management/routes/app_route.dart';

import '../../helper/utils.dart';

class SingleMemberReport extends StatelessWidget {
  final UserReportModel userReportModel;

  const SingleMemberReport({super.key, required this.userReportModel});

  @override
  Widget build(BuildContext context) {
    var isOnPhone = MediaQuery.of(context).size.width < Constants.smallScreenSize;

    return Card(
      child: InkWell(
        child: Flex(
          direction: isOnPhone ? Axis.vertical : Axis.horizontal,
          children: [
            SizedBox(
              width: isOnPhone ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.5,
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: userReportModel.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: imageProvider, fit: BoxFit.scaleDown),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                title: Text('${userReportModel.name} (${userReportModel.nickName})'),
                subtitle: Text('${userReportModel.identity}\n${userReportModel.phoneNumber}\n${userReportModel.bankName} - ${userReportModel.bankNumber}\n${userReportModel.address}\n${userReportModel.additionalInfo}'),
                // trailing: Text(
                //     'Âm/dương: ${Utils.moneyFormat.format(userReportModel.fundRatio)}đ'),
                onTap: () {
                  context.router.push(MemberEditRoute(isCreateNew: false, user: userReportModel));
                },
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            SizedBox(
              width: isOnPhone ? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width * 0.3,
              child: Padding(
                padding: isOnPhone ? const EdgeInsets.fromLTRB(0, 5, 0, 10) : const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: isOnPhone ? MainAxisAlignment.center : MainAxisAlignment.end,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tổng tiền hụi sống: '),
                        Text('Tổng tiền hụi chết: '),
                        Divider(),
                        Text('Âm/Dương: '),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${Utils.moneyFormat.format(userReportModel.totalAliveAmount)}đ'),
                        Text('${Utils.moneyFormat.format(userReportModel.totalDeadAmount)}đ'),
                        Divider(),
                        Text('${Utils.moneyFormat.format(userReportModel.fundRatio)}đ'),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
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
    final memberReportWidgets = widget.userReportModels.where((element) => element.toString().toLowerCase().replaceAll(' ', '').contains(filterText.toLowerCase())).map((e) => SingleMemberReport(userReportModel: e)).toList();
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
