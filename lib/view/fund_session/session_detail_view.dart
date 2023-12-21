import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/fund_session_model.dart';
import 'package:hui_management/provider/payment_provider.dart';
import 'package:provider/provider.dart';
import '../../helper/utils.dart';
import '../../routes/app_route.dart';
import 'taken_session_info_widget.dart';

enum SessionDetailMenuOption { payment, billTaken }

class SessionDetailPopupMenuWidget extends StatelessWidget {
  final NormalSessionDetail sessionDetail;
  final FundSession? session;

  const SessionDetailPopupMenuWidget({super.key, required this.sessionDetail, this.session});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context, listen: true);

    return PopupMenuButton<SessionDetailMenuOption>(
      onSelected: (SessionDetailMenuOption menuOption) async {
        if (menuOption == SessionDetailMenuOption.payment) {
          await paymentProvider
              .getPaymentsFilterBy(subUserId: sessionDetail.fundMember.subUser.id, sessionDetailId: sessionDetail.id)
              .match(
                (l) => DialogHelper.showSnackBar(context, 'Có lỗi xảy ra khi lấy thông tin thanh toán CODE: $l'),
                (r) => context.router.push(PaymentDetailRoute(payment: r.first)),
              )
              .run();
        } else if (menuOption == SessionDetailMenuOption.billTaken && session != null) {
          context.router.push(FundNormalSessionExportPdfRoute(takenSessionDetail: sessionDetail, session: session!));
        }
      },
      itemBuilder: (context) {
        final menu = <PopupMenuEntry<SessionDetailMenuOption>>[
          const PopupMenuItem<SessionDetailMenuOption>(
            value: SessionDetailMenuOption.payment,
            child: Text('Bill thanh toán'),
          ),
        ];

        if (sessionDetail.type == NormalSessionDetailType.emergencyTaken || sessionDetail.type == NormalSessionDetailType.taken) {
          menu.add(const PopupMenuItem<SessionDetailMenuOption>(
            value: SessionDetailMenuOption.billTaken,
            child: Text('Bill giao hụi'),
          ));
        }

        return menu;
      },
    );
  }
}

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
            Positioned(right: 0, child: SessionDetailPopupMenuWidget(sessionDetail: takenSessionDetail, session: session)),
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
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Hốt hụi trước: ${Utils.moneyFormat.format(normalSessionDetail.payCost)}đ', textAlign: TextAlign.right, style: const TextStyle(color: Colors.black)),
                SessionDetailPopupMenuWidget(sessionDetail: normalSessionDetail),
              ],
            ),
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
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('$fundSessionType: ${Utils.moneyFormat.format(normalSessionDetail.payCost)}đ', textAlign: TextAlign.right, style: const TextStyle(color: Colors.black)),
                SessionDetailPopupMenuWidget(sessionDetail: normalSessionDetail),
              ],
            ),
          ),
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
        case NormalSessionDetailType.dead:
          sessionDetailWidgets.add(NormalSessionDetailMemberWidget(normalSessionDetail: sessionDetail));
          break;
        case NormalSessionDetailType.alive:
          sessionDetailWidgets.add(NormalSessionDetailMemberWidget(normalSessionDetail: sessionDetail));
          break;
        case NormalSessionDetailType.emergencyTaken:
          sessionDetailWidgets.add(EmergencySessionDetailMemberWidget(normalSessionDetail: sessionDetail));
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
