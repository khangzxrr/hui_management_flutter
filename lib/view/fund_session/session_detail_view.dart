import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/fund_session_model.dart';
import '../../helper/utils.dart';

class TakenSessionDetailWidget extends StatelessWidget {
  final NormalSessionDetail takenSessionDetail;

  const TakenSessionDetailWidget({super.key, required this.takenSessionDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CachedNetworkImage(
              imageUrl: takenSessionDetail.fundMember.user.imageUrl,
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
            title: Text(
              takenSessionDetail.fundMember.nickName,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text('Tổng tiền sống + chết: ${Utils.moneyFormat.format(takenSessionDetail.fundAmount)}đ\nThăm kêu: ${Utils.moneyFormat.format(takenSessionDetail.predictedPrice)}đ\nTrừ hoa hồng: ${Utils.moneyFormat.format(takenSessionDetail.serviceCost)}đ\nCòn lại: ${Utils.moneyFormat.format(takenSessionDetail.payCost)}đ', textAlign: TextAlign.right, style: const TextStyle(color: Colors.white)),
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
    String fundSessionType = "";

    if (normalSessionDetail.type == "Alive") {
      fundSessionType = "Tiền hụi sống";
    } else {
      fundSessionType = "Tiền hụi chết";
    }

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CachedNetworkImage(
              imageUrl: normalSessionDetail.fundMember.user.imageUrl,
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
            title: Text(normalSessionDetail.fundMember.nickName),
            subtitle: Text('$fundSessionType: ${Utils.moneyFormat.format(normalSessionDetail.payCost)}đ', textAlign: TextAlign.right, style: const TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}

@RoutePage()
class SessionDetailScreen extends StatelessWidget {
  final FundSession session;
  final String fundName;

  const SessionDetailScreen({super.key, required this.fundName, required this.session});

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    //widgets.add(TakenSessionDetailWidget(takenSessionDetail: session.takenSessionDetail));

    widgets.addAll(
      session.normalSessionDetails.map(
        (normalSessionDetail) => normalSessionDetail.type == "Taken" ? TakenSessionDetailWidget(takenSessionDetail: normalSessionDetail) : NormalSessionDetailMemberWidget(normalSessionDetail: normalSessionDetail),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('dây hụi $fundName kỳ ${session.sessionNumber}'),
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
