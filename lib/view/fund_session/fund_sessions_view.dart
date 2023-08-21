import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/fund_session_model.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/view/fund_session/session_detail_view.dart';
import 'package:provider/provider.dart';

import '../../helper/dialog.dart';
import '../../helper/utils.dart';
import '../../routes/app_route.dart';
import 'taken_session_info_widget.dart';

class SessionViewWidget extends StatelessWidget {
  final FundSession session;

  const SessionViewWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final isOnPhone = MediaQuery.of(context).size.width < Constants.smallScreenSize;

    final fundProvider = Provider.of<FundProvider>(context);

    NormalSessionDetail takenSessionDetail = session.normalSessionDetails.where((d) => d.type == "Taken").first;
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
              }, (r) => DialogHelper.showSnackBar(context, "Xóa kì hụi thành công!")).run();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Card(
        child: InkWell(
          onTap: () => context.router.push(
            SessionDetailRoute(fundName: fundProvider.fund.name, session: session, memberCount: fundProvider.fund.membersCount),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                dense: true,
                leading: isOnPhone
                    ? null
                    : CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text('K${session.sessionNumber}'),
                      ),
                title: TakenSessionInfoWidget(
                  takenSessionDetail: takenSessionDetail,
                  session: session,
                  memberCount: fundProvider.fund.membersCount,
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

    final sesionViewWidgets = fundProvider.fund.sessions.map((session) => SessionViewWidget(session: session)).toList();

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
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
            onPressed: () => context.router.push(const CreateSessionSelectMemberRoute()),
            icon: const Icon(Icons.add),
            label: const Text('Khui hụi'),
          ),
          TextButton.icon(
            onPressed: () => context.router.popUntil((route) => route.settings.name == FundDetailRoute.name),
            icon: const Icon(Icons.home),
            label: const Text('Trở về trang quản lí dây hụi'),
          ),
        ],
      )),
    );
  }
}
