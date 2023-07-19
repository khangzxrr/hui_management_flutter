import 'package:flutter/material.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:hui_management/model/payment_fund_bill_model.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:pluto_grid/pluto_grid.dart';

class DisplayBillOwnerInfoWidget extends StatelessWidget {
  final UserModel owner;

  const DisplayBillOwnerInfoWidget({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(children: [
        Text(
          'chủ hụi ${owner.name}',
          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        ),
        const SizedBox(height: 5),
        Text('Số điện thoại: ${owner.phonenumber}'),
        const SizedBox(height: 5),
        Text('Tên ngân hàng: ${owner.bankname} - Số tài khoản: ${owner.banknumber}'),
        const SizedBox(height: 5),
        const Divider(),
      ]),
    );
  }
}

class PaymentDetailTableViewWidget extends StatelessWidget {
  final PaymentModel payment;

  PaymentDetailTableViewWidget({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final transferToOwnerTextStyle = Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill của Lan Lan ngày ${Utils.dateFormat.format(payment.createAt)}'),
      ),
      body: Container(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            DisplayBillOwnerInfoWidget(
              owner: UserModel(
                additionalInfo: 'asds',
                address: 'asdsa',
                bankname: 'MB bank',
                banknumber: '32143352',
                email: 'asdijwqd@gmail.com',
                id: 3,
                name: 'Nguyễn Thị Bảo Châu',
                password: '123123aaa',
                phonenumber: '086452333',
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hụi viên Lan Lan',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'images/avatar.jpg',
                                  height: 75,
                                  width: 75,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text('Ngân hàng MB bank\nSố tài khoản: 0862106650\nSố điện thoại: 0862106650\nEmail: khangzxrr@gmail.com')
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      child: VerticalDivider(width: 20),
                    ),
                    Expanded(
                      child: Text(
                        'Hụi chết: 4,000,000đ\nHụi sống: 31,175,000đ\nÂm/Dương: 27,175,000đ\nLợi nhuận: 14,215,000đ',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dây hụi 2,000,000đ',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text('Mã: 23\nNgày mở: 24/12/23\nKhui: Tuần đầu 2tr 7\nKỳ 25/27'),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      child: VerticalDivider(width: 20),
                    ),
                    Expanded(
                      child: Text(
                        'Tiền hốt 49,800,000đ',
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dây hụi 1,000,000đ',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text('Mã: 23\nNgày mở: 24/12/23\nKhui: NGÀY 1TR ĐẦU D3\nKỳ 18/30'),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      child: VerticalDivider(width: 20),
                    ),
                    Expanded(
                      child: Text(
                        'Tiền đóng 950,000đ',
                        textAlign: TextAlign.end,
                        style: transferToOwnerTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dây hụi 800,000đ',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text('Mã: 23\nNgày mở: 11/06/23\nKhui: ĐẦU 800 NGÀY D1\nKỳ 20/30'),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      child: VerticalDivider(width: 20),
                    ),
                    Expanded(
                      child: Text(
                        'Tiền đóng 730,000đ',
                        textAlign: TextAlign.end,
                        style: transferToOwnerTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleMedium,
                    children: const <TextSpan>[
                      TextSpan(text: 'Tổng tiền đóng: '),
                      TextSpan(text: '1,680,000đ\n', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'Tổng tiền hốt: '),
                      TextSpan(text: '49,800,000đ\n', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'Tổng còn lại phải giao: '),
                      TextSpan(text: '48,120,000đ\n', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: 'Chủ hụi phải chi tiền cho hụi viên',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            backgroundColor: Colors.green,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            FilledButton(onPressed: () {}, child: const Text('Đã thanh toán bill này'))
          ],
        ),
      ),
    );
  }
}
