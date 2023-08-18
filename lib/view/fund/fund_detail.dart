import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:provider/provider.dart';

import '../../helper/utils.dart';
import '../../routes/app_route.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tên:    ', textAlign: TextAlign.left),
                        Text('ngày khui hụi: ', textAlign: TextAlign.left),
                        Text('ngày giao hụi: ', textAlign: TextAlign.left),
                        Text('Mệnh giá:    ', textAlign: TextAlign.left),
                        Text('Hoa hồng:    ', textAlign: TextAlign.left),
                        Text('Ngày tạo hụi:    ', textAlign: TextAlign.left),
                        Text('Ngày kết thúc dây hụi: ', textAlign: TextAlign.left),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(fundProvider.fund.name, textAlign: TextAlign.right),
                        Text(Utils.dateFormat.format(fundProvider.fund.nextSessionDurationDate), textAlign: TextAlign.right),
                        Text(Utils.dateFormat.format(fundProvider.fund.nextTakenSessionDeliveryDate), textAlign: TextAlign.right),
                        Text('${Utils.moneyFormat.format(fundProvider.fund.fundPrice)}đ', textAlign: TextAlign.right),
                        Text('${Utils.moneyFormat.format(fundProvider.fund.serviceCost)}đ', textAlign: TextAlign.right),
                        Text(Utils.dateFormat.format(fundProvider.fund.openDate), textAlign: TextAlign.right),
                        Text(Utils.dateFormat.format(fundProvider.fund.endDate), textAlign: TextAlign.right),
                      ],
                    )
                  ],
                ),
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
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: fundProvider.fund.sessionsCount == fundProvider.fund.membersCount
            ? null
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton.extended(
                      onPressed: () => context.router.push(const FundReportRoute()),
                      heroTag: null,
                      label: const Text('Tạo giấy hụi'),
                      icon: const Icon(Icons.money_rounded),
                    ),
                    const SizedBox(height: 12),
                    FloatingActionButton.extended(
                      onPressed: () => context.router.push(const CreateSessionSelectMemberRoute()),
                      heroTag: null,
                      label: const Text('Khui hụi'),
                      icon: const Icon(Icons.money_rounded),
                    )
                  ],
                ),
              ));
  }
}
