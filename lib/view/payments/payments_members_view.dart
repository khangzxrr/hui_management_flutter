import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:hui_management/provider/users_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/payment_provider.dart';
import 'funds_payments_detail.dart';

class MemberWidget extends StatelessWidget {
  final UserModel user;

  const MemberWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                ),
                title: Text(user.name),
                subtitle: Text('${user.email}\n${user.phonenumber}\n${user.bankname} - ${user.banknumber}\n${user.address}\n${user.additionalInfo}'),
              )
            ],
          ),
          onTap: () {
            //todo fix member provider inside build
            //add ui for payments
            Provider.of<PaymentProvider>(context, listen: false).getPayments(user.id).match((l) => log(l), (r) => log("ok")).run();

            Navigator.of(context).push(MaterialPageRoute(builder: (builder) => PaymentSummariesWidget(user: user)));
          }),
    );
  }
}

class PaymentMembersViewWidget extends StatelessWidget {
  const PaymentMembersViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    usersProvider.getAllUsers().getOrElse((l) {
      DialogHelper.showSnackBar(context, 'Có lỗi khi lấy danh sách thành viên');
      Navigator.of(context).pop();
    }).run();

    final List<Widget> userWidgets = [];

    userWidgets.addAll(
      usersProvider.users.map((user) => MemberWidget(user: user)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí thanh toán'),
      ),
      body: ListView(
        children: userWidgets,
      ),
    );
  }
}
