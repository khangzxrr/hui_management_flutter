import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/view/fund_members_view.dart';
import 'package:provider/provider.dart';

import '../helper/utils.dart';
import 'fund_session/fund_sessions_view.dart';
import 'fund_session/session_create_select_member.dart';

class FundDetailWidget extends StatelessWidget {
  const FundDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dây hụi ${fundProvider.fund.name}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Tên: ${fundProvider.fund.name}\nNgày mở hụi: ${fundProvider.fund.openDateText}\nDây hụi ${fundProvider.fund.fundPrice}.000đ\nHoa hồng: ${fundProvider.fund.serviceCost}.000đ\nNgày tạo hụi: ${Utils.dateFormat.format(fundProvider.fund.openDate)}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FundMembersWidget()),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            'Quản lí hụi viên',
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FundSessionsWidget()),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            'Quản lí các kì',
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
      floatingActionButton: ExpandableFab(
        children: [
          FloatingActionButton(
            onPressed: () {},
            heroTag: null,
            child: const Icon(Icons.person_add),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SessionCreateSelectMemberWidget()),
              );
            },
            heroTag: null,
            child: const Icon(Icons.paid),
          ),
        ],
      ),
    );
  }
}
