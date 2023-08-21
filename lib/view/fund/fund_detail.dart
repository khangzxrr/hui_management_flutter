import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:provider/provider.dart';

import '../../helper/utils.dart';
import '../../model/general_fund_model.dart';
import '../../routes/app_route.dart';
import 'fund_info_widget.dart';

@RoutePage()
class FundDetailScreen extends StatelessWidget {
  const FundDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('DÂY HỤI ${fundProvider.fund.name}'),
        actions: [
          IconButton(
            onPressed: () {
              context.router
                  .push(
                    FundEditRoute(isNew: false, fund: fundProvider.fund),
                  )
                  .then(
                    (value) => fundProvider.getFund(fundProvider.fund.id).run(),
                  );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              FundInfoWidget(fund: fundProvider.fund),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () => context.router.push(const FundMembersRoute()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            'QUẢN LÝ HỤI VIÊN',
                            style: TextStyle(fontSize: 24, color: Colors.grey[800]),
                          ),
                          Container(height: 10),
                          Text(
                            'Số hụi viên: ${fundProvider.fund.membersCount}',
                            style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () => context.router.push(const FundSessionListRoute()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            'QUẢN LÝ CÁC KỲ HỤI',
                            style: TextStyle(fontSize: 24, color: Colors.grey[800]),
                          ),
                          Container(height: 10),
                          Text(
                            'Các kỳ đã khui ${fundProvider.fund.sessionsCount} (còn lại ${fundProvider.fund.membersCount - fundProvider.fund.sessionsCount} kỳ)',
                            style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionTile(
                title: const Text('Dự đoán ngày khui tiếp theo'),
                children: fundProvider.fund.newSessionCreateDates
                    .map((date) => Text(
                          Utils.dateFormat.format(date.toLocal()),
                          textAlign: TextAlign.start,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () => context.router.push(const FundReportRoute()),
              label: const Text('Tạo giấy hụi'),
              icon: const Icon(Icons.download_rounded),
            ),
            SizedBox(width: 10),
            TextButton.icon(
              onPressed: () => context.router.push(const CreateSessionSelectMemberRoute()),
              label: const Text('Khui hụi'),
              icon: const Icon(Icons.money_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
