import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/model/user_with_payment_report.dart';
import 'package:hui_management/provider/sub_users_provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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
                  width: MediaQuery.of(context).size.width * (isOnPhone ? 0.9 : 0.6),
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
                        Text('Tổng tiền cần ${(user.totalProcessingAmount > 0) ? 'thu' : 'trả'}:  '),
                        const Text('Đã thanh toán: '),
                        const Text('Còn nợ: '),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${Utils.moneyFormat.format(user.totalProcessingAmount.abs())}đ'),
                        Text('${Utils.moneyFormat.format(user.totalDebtAmount)}đ'), //lazy to change the name!
                        Text('${Utils.moneyFormat.format(user.totalProcessingAmount.abs() - user.totalDebtAmount)}đ'),
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
          Provider.of<PaymentProvider>(context, listen: false).getPayments(user).match((l) {
            log(l);
            DialogHelper.showSnackBar(context, 'Lỗi khi lấy bill thanh toán');
          }, (r) => context.router.push(PaymentListOfUserRoute(user: user))).run();
        },
      ),
    );
  }
}

@RoutePage()
class MultiplePaymentMembersScreen extends StatefulWidget {
  const MultiplePaymentMembersScreen({super.key});

  @override
  State<MultiplePaymentMembersScreen> createState() => _MultiplePaymentMembersScreenState();
}

class _MultiplePaymentMembersScreenState extends State<MultiplePaymentMembersScreen> {
  String filterText = '';

  @override
  Widget build(BuildContext context) {
    final subUsersProvider = Provider.of<SubUsersProvider>(context, listen: true);

    final List<Widget> userWidgets = subUsersProvider.subUsersWithPaymentReport
        .where(
          (u) => u.toString().toLowerCase().replaceAll(' ', '').contains(filterText.toLowerCase()),
        )
        .map((e) => SingleMemberScreen(user: e))
        .toList();

    return LiquidPullToRefresh(
      onRefresh: () async {
        await subUsersProvider.getAllWithPaymentReport().run();
      },
      showChildOpacityTransition: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
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
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      filterText = '';
                    });
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
            ...userWidgets,
          ],
        ),
      ),
    );
  }
}
