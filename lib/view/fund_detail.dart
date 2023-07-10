import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:hui_management/view/fund_members_view.dart';

import '../helper/utils.dart';
import '../model/fund_model.dart';

class FundDetailWidget extends StatelessWidget {
  final Fund fund;

  FundDetailWidget({super.key, required this.fund});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dây hụi ${fund.name}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Tên: ${fund.name}\nNgày mở hụi: ${fund.openDateText}\nDây hụi ${fund.fundPrice}.000đ\nHoa hồng: ${fund.serviceCost}.000đ\nSố phần: ${fund.membersCount}\nNgày tạo hụi: ${Utils.dateFormat.format(fund.openDate)}',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30, width: 30),
              Text('Các kỳ đã khui ${fund.sessionsCount} (còn lại ${fund.membersCount - fund.sessionsCount} kỳ)'),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FundMembersWidget()),
                    );
                  },
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
                            'Nhấn vào đây để thêm xóa sửa các hụi viên',
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
                  onTap: () {},
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
                            'Nhấn vào đây để chỉnh sửa các kì',
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
            onPressed: () {},
            heroTag: null,
            child: const Icon(Icons.paid),
          ),
        ],
      ),
    );
  }
}
