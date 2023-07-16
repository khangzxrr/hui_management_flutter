import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:hui_management/provider/payment_provider.dart';
import 'package:provider/provider.dart';

class PaymentWidget extends StatelessWidget {
  final PaymentModel payment;

  const PaymentWidget({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Text(payment.createAt.toString());
  }
}

class PaymentSummariesWidget extends StatelessWidget {
  final UserModel user;

  const PaymentSummariesWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    final List<Widget> paymentWidgets = paymentProvider.payments
        .map(
          (payment) => PaymentWidget(payment: payment),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bill của ${user.name}'),
      ),
      body: ListView(
        children: paymentWidgets,
      ),
    );
  }
}
