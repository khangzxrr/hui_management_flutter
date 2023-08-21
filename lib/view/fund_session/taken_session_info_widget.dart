import 'package:flutter/material.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/fund_session_model.dart';

import '../../helper/utils.dart';

class TakenSessionInfoWidget extends StatelessWidget {
  final NormalSessionDetail takenSessionDetail;

  final FundSession session;

  final int memberCount;

  const TakenSessionInfoWidget({
    super.key,
    required this.takenSessionDetail,
    required this.session,
    required this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ngày khui hụi: '),
            Text('Lần hốt: '),
            Text('Thành viên hốt: '),
            Text('Thăm kêu: '),
            Text('Chịu lỗ: '),
            Text('Tiền hốt hụi: '),
            Text('Trừ hoa hồng: '),
            Text('Tiền hốt hụi còn lại: '),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(Utils.dateFormat.format(session.takenDate)),
            Text('${session.sessionNumber}/$memberCount'),
            Text(takenSessionDetail.fundMember.nickName),
            Text('${Utils.moneyFormat.format(takenSessionDetail.predictedPrice)}đ'),
            Text('${Utils.moneyFormat.format(takenSessionDetail.lossCost)}đ'),
            Text('${Utils.moneyFormat.format(takenSessionDetail.fundAmount)}đ'),
            Text('${Utils.moneyFormat.format(takenSessionDetail.serviceCost)}đ'),
            Text('${Utils.moneyFormat.format(takenSessionDetail.payCost)}đ'),
          ],
        )
      ],
    );
  }
}
