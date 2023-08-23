import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/model/general_fund_model.dart';

import '../../helper/utils.dart';

class FundInfoWidget extends StatelessWidget {
  final GeneralFundModel fund;
  const FundInfoWidget({super.key, required this.fund});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loại hụi', textAlign: TextAlign.left),
            Text('Tên dây hụi: ', textAlign: TextAlign.left),
            Text('Mệnh giá: ', textAlign: TextAlign.left),
            Text('Hoa hồng: ', textAlign: TextAlign.left),
            Text('Khui lúc:', textAlign: TextAlign.left),
            Text('Giao lúc:', textAlign: TextAlign.left),
            Text('Ngày mở: ', textAlign: TextAlign.left),
            Text('Ngày kết thúc: ', textAlign: TextAlign.left),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(fund.fundType == FundType.dayFund ? 'Hụi ngày' : 'Hụi tháng', textAlign: TextAlign.right),
            Text(fund.name, textAlign: TextAlign.right),
            Text('${Utils.moneyFormat.format(fund.fundPrice)}đ', textAlign: TextAlign.right),
            Text('${Utils.moneyFormat.format(fund.serviceCost)}đ', textAlign: TextAlign.right),
            Text(fund.createSessionDurationAt(), textAlign: TextAlign.right),
            Text(fund.takenSessionDeliveryAt(), textAlign: TextAlign.right),
            Text(Utils.dateFormat.format(fund.openDate.toLocal()), textAlign: TextAlign.right),
            Text(Utils.dateFormat.format(fund.endDate.toLocal()), textAlign: TextAlign.right),
          ],
        )
      ],
    );
  }
}
