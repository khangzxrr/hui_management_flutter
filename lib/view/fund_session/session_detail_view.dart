import 'package:flutter/material.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/fund_session_model.dart';
import '../../helper/utils.dart';
import '../../model/fund_taken_session_detail_model.dart';

class TakenSessionDetailWidget extends StatelessWidget {
  final TakenSessionDetail takenSessionDetail;

  const TakenSessionDetailWidget({super.key, required this.takenSessionDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
            ),
            title: Text(
              takenSessionDetail.fundMember.nickName,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text('Thăm kêu: ${Utils.moneyFormat.format(takenSessionDetail.predictedPrice)}đ\nTiền hụi: ${Utils.moneyFormat.format(takenSessionDetail.fundAmount)}đ\nTrừ hoa hồng: ${Utils.moneyFormat.format(takenSessionDetail.serviceCost)}đ\nCòn lại: ${Utils.moneyFormat.format(takenSessionDetail.remainPrice)}đ', textAlign: TextAlign.right, style: const TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}

class NormalSessionDetailMemberWidget extends StatelessWidget {
  final NormalSessionDetail normalSessionDetail;

  const NormalSessionDetailMemberWidget({super.key, required this.normalSessionDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
            ),
            title: Text(normalSessionDetail.fundMember.nickName),
            subtitle: Text('Tiền hụi sống: ${Utils.moneyFormat.format(normalSessionDetail.payCost)}đ', textAlign: TextAlign.right, style: const TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}

class SessionDetailWidget extends StatelessWidget {
  final FundSession session;

  const SessionDetailWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    widgets.add(TakenSessionDetailWidget(takenSessionDetail: session.takenSessionDetail));

    widgets.addAll(session.normalSessionDetails.map(
      (normalSessionDetail) => NormalSessionDetailMemberWidget(normalSessionDetail: normalSessionDetail),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('dây hụi abc Kì 1'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        ),
      ),
    );
  }
}
