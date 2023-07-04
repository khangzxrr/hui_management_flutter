import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hui_management/view/fund_detail_member.dart';
import 'package:hui_management/view/session_view.dart';
import 'package:hui_management/view/member_edit.dart';

class FundDetailWidget extends StatelessWidget {
  const FundDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dây hụi abc xyz'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Ngày mở hụi: 13/08/2022\nDây hụi 1,000.000đ\nThời gian khui: T2 mỗi tuần\nSố phần: 16\nGhi chú: đây là hụi abcxyz...',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30, width: 30),
              Text('Các kỳ đã khui (còn lại N kỳ)'),
              SessionViewWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
