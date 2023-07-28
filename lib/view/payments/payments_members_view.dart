import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:provider/provider.dart';

import '../../provider/payment_provider.dart';
import '../../routes/app_route.dart';
import 'payment_summaries_view.dart';

class SingleMemberScreen extends StatelessWidget {
  final UserModel user;

  const SingleMemberScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CachedNetworkImage(
                  imageUrl: user.absoluteImageUrl!,
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
                title: Text(user.name),
                subtitle: Text('${user.identity}\n${user.phonenumber}\n${user.bankname} - ${user.banknumber}\n${user.address}\n${user.additionalInfo}'),
              )
            ],
          ),
          onTap: () {
            //todo fix member provider inside build
            //add ui for payments
            Provider.of<PaymentProvider>(context, listen: false).getPayments(user.id).match((l) {
              log(l);
              DialogHelper.showSnackBar(context, 'Lỗi khi lấy bill thanh toán');
            }, (r) => context.router.push(PaymentListOfUserRoute(user: user))).run();
          }),
    );
  }
}

@RoutePage()
class MultiplePaymentMembersScreen extends StatelessWidget {
  final List<UserModel> users;

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
