import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/fund_session_model.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:provider/provider.dart';

import '../../helper/dialog.dart';
import '../../helper/utils.dart';
import '../../routes/app_route.dart';

class SessionViewWidget extends StatelessWidget {
  final FundSession session;

  const SessionViewWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context);

    NormalSessionDetail takenSessionDetail =
        session.normalSessionDetails.where((d) => d.type == "Taken").first;
    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          SlidableAction(
            onPressed: (context) {
              fundProvider
                  .removeSession(session.id)
                  .andThen(
                    () => fundProvider.getFund(fundProvider.fund.id),
                  )
                  .match((l) {
                log(l);
                DialogHelper.showSnackBar(context, l);
              },
                      (r) => DialogHelper.showSnackBar(
                          context, "Xóa kì hụi thành công!")).run();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Card(
        child: InkWell(
          onTap: () => context.router.push(SessionDetailRoute(
              fundName: fundProvider.fund.name, session: session)),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text('K${session.sessionNumber}'),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ngày khui hụi: '),
                        Text('Lần hốt (hiện tại/tổng số): '),
                        Text('Thành viên hốt: '),
                        Text('Thăm kêu: '),
                        Text('Chịu lỗ: '),
                        Text('Tiền hốt hụi: '),
                        Text('Trừ hoa hồng: '),
                        Text('Tiền hốt hụi còn lại: '),
                        //Kỳ ${session.sessionNumber}\nThành viên hốt: ${takenSessionDetail.fundMember.nickName}\nThăm kêu: ${Utils.moneyFormat.format(takenSessionDetail.predictedPrice)}đ\nTổng tiền sống + chết: ${Utils.moneyFormat.format(takenSessionDetail.fundAmount)}đ\nTrừ hoa hồng: ${Utils.moneyFormat.format(takenSessionDetail.serviceCost)}đ\nCòn lại: ${Utils.moneyFormat.format(takenSessionDetail.payCost)}đ', textAlign: TextAlign.right)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(Utils.dateFormat.format(session.takenDate)),
                        Text(
                            '${session.sessionNumber}/${fundProvider.fund.membersCount}'),
                        Text(takenSessionDetail.fundMember.nickName),
                        Text(
                            '${Utils.moneyFormat.format(takenSessionDetail.predictedPrice)}đ'),
                        Text(
                            '${Utils.moneyFormat.format(takenSessionDetail.lossCost)}đ'),
                        Text(
                            '${Utils.moneyFormat.format(takenSessionDetail.fundAmount)}đ'),
                        Text(
                            '${Utils.moneyFormat.format(takenSessionDetail.serviceCost)}đ'),
                        Text(
                            '${Utils.moneyFormat.format(takenSessionDetail.payCost)}đ'),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@RoutePage()
class FundSessionListScreen extends StatelessWidget {
  const FundSessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context);

    final sesionViewWidgets = fundProvider.fund.sessions
        .map((session) => SessionViewWidget(session: session))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lí các kì của dây hụi ${fundProvider.fund.name}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: sesionViewWidgets,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.router
            .pushAndPopUntil(const DashboardRoute(), predicate: (_) => false),
        heroTag: null,
        label: const Text('Menu chính'),
        icon: const Icon(Icons.home),
      ),
    );
  }
}
