import 'package:flutter/material.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:hui_management/model/payment_fund_bill_model.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/user_model.dart';

class DisplayBillOwnerInfoWidget extends StatelessWidget {
  final UserModel owner;

  const DisplayBillOwnerInfoWidget({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(children: [
        Text(
          owner.name,
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

class FundBillWidget extends StatelessWidget {
  final FundBillModel fundBill;

  const FundBillWidget({super.key, required this.fundBill});

  @override
  Widget build(BuildContext context) {
    String fundBillType = "";

    if (fundBill.fromSessionDetail.type == "Taken") {
      fundBillType = "Hốt hụi";
    } else if (fundBill.fromSessionDetail.type == "Alive") {
      fundBillType = "Hụi sống";
    } else {
      fundBillType = "Hụi chết";
    }

    return Card(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Kì ${fundBill.fromSession.sessionNumber} khui vào ngày ${Utils.dateFormat.format(fundBill.fromSession.takenDate)}'),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$fundBillType dưới tên '),
                Text(
                  fundBill.fromSessionDetail.fundMember.nickName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Số tiền thanh toán: '),
                Text(
                  '${Utils.moneyFormat.format(fundBill.fromSessionDetail.payCost)}đ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FundGroupWidget extends StatelessWidget {
  final GeneralFundModel fund;
  final List<FundBillModel> fundBills;

  const FundGroupWidget({super.key, required this.fundBills, required this.fund});

  @override
  Widget build(BuildContext context) {
    final groupedBills = fundBills.where((fb) => fb.fromFund.id == fund.id);

    double totalCost = groupedBills.fold(0, (sum, item) => sum + ((item.fromSessionDetail.type == 'Taken') ? -item.fromSessionDetail.payCost : item.fromSessionDetail.payCost));

    String collectOrPay;

    if (totalCost < 0) {
      collectOrPay = 'chi: ${Utils.moneyFormat.format(totalCost.abs())}đ';
    } else {
      collectOrPay = 'thu:  ${Utils.moneyFormat.format(totalCost.abs())}đ';
    }

    return ExpansionTile(
      title: Text('Dây hụi ${fund.name} - Mở ngày: ${Utils.dateFormat.format(fund.openDate)}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Còn lại (${fund.sessionsCount}/${fund.membersCount}) kì'),
          Row(
            children: [
              const Text('Tổng tiền mà chủ hụi phải '),
              Text(collectOrPay, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
      children: groupedBills.map((fb) => FundBillWidget(fundBill: fb)).toList(),
    );
  }
}

class GroupBillsByFundWidget extends StatelessWidget {
  final List<FundBillModel> fundBills;

  const GroupBillsByFundWidget({super.key, required this.fundBills});

  @override
  Widget build(BuildContext context) {
    //List<Widget> fundBillWidgets = fundBills.map((fundBill) => FundBillWidget(fundBill: fundBill)).toList();

    final seenId = Set<int>();
    List<GeneralFundModel> funds = fundBills.map((bill) => bill.fromFund).where((f) => seenId.add(f.id)).toList();

    List<Widget> groupedFundBillWidgets = funds
        .map(
          (f) => FundGroupWidget(fundBills: fundBills, fund: f),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: groupedFundBillWidgets,
    );
  }
}

class PaymentDetailWidget extends StatelessWidget {
  final PaymentModel payment;

  const PaymentDetailWidget({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill của ${payment.owner.name} ngày ${Utils.dateFormat.format(payment.createAt)}'),
      ),
      body: ListView(
        children: [
          DisplayBillOwnerInfoWidget(owner: payment.owner),
          GroupBillsByFundWidget(fundBills: payment.fundBills),
          const Divider(),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Text(
                  'Tổng tiền phải ${payment.totalCost < 0 ? 'chi' : 'thu'} là ${Utils.moneyFormat.format(payment.totalCost.abs())}đ',
                  style: (payment.totalCost < 0)
                      ? const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red,
                        )
                      : const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                ),
                const SizedBox(height: 10),
                FilledButton(onPressed: () {}, child: const Text('Thanh toán bill này'))
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
