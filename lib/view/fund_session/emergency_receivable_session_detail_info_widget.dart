import 'package:flutter/material.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/fund_session_model.dart';

import '../../helper/utils.dart';

class EmergencyReceivableSessionDetailInfoWidget extends StatelessWidget {
  final NormalSessionDetail takenSessionDetail;

  final FundSession session;

  final int memberCount;

  final Color textColor;

  const EmergencyReceivableSessionDetailInfoWidget({
    super.key,
    required this.takenSessionDetail,
    required this.session,
    required this.memberCount,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Đã hốt giao trước: ', style: TextStyle(color: textColor)),
                Text('Ngày khui hụi: ', style: TextStyle(color: textColor)),
                Text('Lần hốt: ', style: TextStyle(color: textColor)),
                Text('Thành viên hốt: ', style: TextStyle(color: textColor)),
                Text('Thăm kêu: ', style: TextStyle(color: textColor)),
                Text('Chịu lỗ: ', style: TextStyle(color: textColor)),
                Text('Tiền hốt hụi: ', style: TextStyle(color: textColor)),
                Text('Trừ hoa hồng: ', style: TextStyle(color: textColor)),
                Text('Tiền hốt hụi còn lại (hụi chết): ', style: TextStyle(color: textColor)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Đã hốt', style: TextStyle(color: textColor)),
                Text(Utils.dateFormat.format(session.takenDate.toLocal()), style: TextStyle(color: textColor)),
                Text('${session.sessionNumber}/$memberCount', style: TextStyle(color: textColor)),
                Text(takenSessionDetail.fundMember.nickName, style: TextStyle(color: textColor)),
                Text('${Utils.moneyFormat.format(takenSessionDetail.predictedPrice)}đ', style: TextStyle(color: textColor)),
                Text('${Utils.moneyFormat.format(takenSessionDetail.lossCost)}đ', style: TextStyle(color: textColor)),
                Text('${Utils.moneyFormat.format(takenSessionDetail.fundAmount)}đ', style: TextStyle(color: textColor)),
                Text('${Utils.moneyFormat.format(takenSessionDetail.serviceCost)}đ', style: TextStyle(color: textColor)),
                Text('${Utils.moneyFormat.format(takenSessionDetail.payCost)}đ', style: TextStyle(color: textColor)),
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
