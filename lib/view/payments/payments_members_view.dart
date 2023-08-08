import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/model/user_with_payment_report.dart';
import 'package:provider/provider.dart';

import '../../helper/dialog.dart';
import '../../helper/utils.dart';
import '../../provider/payment_provider.dart';
import '../../routes/app_route.dart';

class SingleMemberScreen extends StatelessWidget {
  final UserWithPaymentReport user;

  const SingleMemberScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var isOnPhone = MediaQuery.of(context).size.width < Constants.smallScreenSize;

    return Card(
      child: InkWell(
        child: Row(
          children: [
            Flex(
              direction: isOnPhone ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * (isOnPhone ? 0.8 : 0.6),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: user.imageUrl,
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
                    title: Text('${user.name} (${user.nickName})'),
                    subtitle: Text('${user.identity}\n${user.phoneNumber}\n${user.bankName} - ${user.bankNumber}\n${user.address}\n${user.additionalInfo}'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tổng tiền cần ${(user.totalCost > 0) ? 'thu' : 'trả'}:  '),
                        const Text('Tổng tiền đã thanh toán:  '),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${Utils.moneyFormat.format(user.totalCost.abs())}đ'),
                        Text('${Utils.moneyFormat.format(user.totalTransactionCost.abs())}đ'),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                  height: 10,
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          //todo fix member provider inside build
          //add ui for payments
          Provider.of<PaymentProvider>(context, listen: false).getPayments(user.id).match((l) {
            log(l);
            DialogHelper.showSnackBar(context, 'Lỗi khi lấy bill thanh toán');
          }, (r) => context.router.push(PaymentListOfUserRoute(user: user))).run();
        },
      ),
    );
  }
}

@RoutePage()
class MultiplePaymentMembersScreen extends StatelessWidget {
  final List<UserWithPaymentReport> users;

  const MultiplePaymentMembersScreen({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final List<Widget> userWidgets = users.map((e) => SingleMemberScreen(user: e)).toList();

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
