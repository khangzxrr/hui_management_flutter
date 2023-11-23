import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/fund_session_model.dart';
import '../../helper/utils.dart';
import '../../routes/app_route.dart';
import 'taken_session_info_widget.dart';

class TakenSessionDetailWidget extends StatelessWidget {
  final NormalSessionDetail takenSessionDetail;
  final FundSession session;
  final int memberCount;

  const TakenSessionDetailWidget({
    super.key,
    required this.takenSessionDetail,
    required this.session,
    required this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () => context.router.push(FundNormalSessionExportPdfRoute(takenSessionDetail: takenSessionDetail, session: session)),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: <Widget>[
            TakenSessionInfoWidget(
              session: session,
              takenSessionDetail: takenSessionDetail,
              memberCount: memberCount,
              textColor: Colors.white,
            ),
            Positioned(
              top: -40,
              child: CachedNetworkImage(
                imageUrl: takenSessionDetail.fundMember.subUser.imageUrl,
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
            ),
          ],
        ),
      ),
    );
  }
}

class FakeAliveSessionDetailMemberWidget extends StatelessWidget {
  final NormalSessionDetail normalSessionDetail;

  const FakeAliveSessionDetailMemberWidget({super.key, required this.normalSessionDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CachedNetworkImage(
              imageUrl: normalSessionDetail.fundMember.subUser.imageUrl,
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
            subtitle: Text('Tiền hụi sống (Đã hốt hụi trước): ${Utils.moneyFormat.format(normalSessionDetail.payCost)}đ', textAlign: TextAlign.right, style: const TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}

class EmergencySessionDetailMemberWidget extends StatelessWidget {
  final NormalSessionDetail normalSessionDetail;

  const EmergencySessionDetailMemberWidget({super.key, required this.normalSessionDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CachedNetworkImage(
              imageUrl: normalSessionDetail.fundMember.subUser.imageUrl,
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
            subtitle: Text('Hốt hụi trước: ${Utils.moneyFormat.format(normalSessionDetail.payCost)}đ', textAlign: TextAlign.right, style: const TextStyle(color: Colors.black)),
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

    if (normalSessionDetail.type == NormalSessionDetailType.alive) {
      fundSessionType = "Tiền hụi sống";
    } else {
      fundSessionType = "Tiền hụi chết";
    }

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CachedNetworkImage(
              imageUrl: normalSessionDetail.fundMember.subUser.imageUrl,
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
  final int memberCount;

  const SessionDetailScreen({super.key, required this.fundName, required this.session, required this.memberCount});

  @override
  Widget build(BuildContext context) {
    final List<Widget> sessionDetailWidgets = [];

    for (final NormalSessionDetail sessionDetail in session.normalSessionDetails) {
      switch (sessionDetail.type) {
        case NormalSessionDetailType.taken:
          sessionDetailWidgets.add(TakenSessionDetailWidget(takenSessionDetail: sessionDetail, session: session, memberCount: memberCount));
          break;
        case NormalSessionDetailType.fakeTaken:
          sessionDetailWidgets.add(TakenSessionDetailWidget(takenSessionDetail: sessionDetail, session: session, memberCount: memberCount));
          break;
        case NormalSessionDetailType.dead:
          sessionDetailWidgets.add(NormalSessionDetailMemberWidget(normalSessionDetail: sessionDetail));
          break;
        case NormalSessionDetailType.alive:
          sessionDetailWidgets.add(NormalSessionDetailMemberWidget(normalSessionDetail: sessionDetail));
          break;
        case NormalSessionDetailType.emergencyTaken:
          sessionDetailWidgets.add(EmergencySessionDetailMemberWidget(normalSessionDetail: sessionDetail));
          break;
        case NormalSessionDetailType.fakeAlive:
          sessionDetailWidgets.add(FakeAliveSessionDetailMemberWidget(normalSessionDetail: sessionDetail));
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('dây hụi $fundName kỳ ${session.sessionNumber}'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.router.popUntil((route) => route.settings.name == FundDetailRoute.name),
        heroTag: null,
        label: const Text('Về trang quản lí dây hụi'),
        icon: const Icon(Icons.home),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              ...sessionDetailWidgets,
            ],
          ),
        ),
      ),
    );
  }
}
