import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:provider/provider.dart';

import '../../helper/utils.dart';
import '../../routes/app_route.dart';
import '../fund_session/fund_sessions_view.dart';

@RoutePage()
class FundDetailScreen extends StatelessWidget {
  const FundDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('DÂY HỤI ${fundProvider.fund.name}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Tên: ', textAlign: TextAlign.right),
                      Text('Ngày mở hụi: ', textAlign: TextAlign.right),
                      Text('Mệnh giá: ', textAlign: TextAlign.right),
                      Text('Hoa hồng: ', textAlign: TextAlign.right),
                      Text('Ngày tạo hụi: ', textAlign: TextAlign.right),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fundProvider.fund.name, textAlign: TextAlign.right),
                      Text(fundProvider.fund.openDateText, textAlign: TextAlign.right),
                      Text('${Utils.moneyFormat.format(fundProvider.fund.fundPrice)}đ', textAlign: TextAlign.right),
                      Text('${Utils.moneyFormat.format(fundProvider.fund.serviceCost)}đ', textAlign: TextAlign.right),
                      Text(Utils.dateFormat.format(fundProvider.fund.openDate), textAlign: TextAlign.right),
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
                            'QUẢN LÍ HỤI VIÊN',
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
                            'QUẢN LÍ CÁC KỲ HỤI',
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
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: fundProvider.fund.sessionsCount == fundProvider.fund.membersCount
          ? null
          : ExpandableFab(
              children: [
                FloatingActionButton(
                  onPressed: () => context.router.push(const CreateSessionSelectMemberRoute()),
                  heroTag: null,
                  child: const Icon(Icons.paid),
                ),
              ],
            ),
    );
  }
}
