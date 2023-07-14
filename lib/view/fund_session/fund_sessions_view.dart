import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hui_management/model/fund_session_model.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/view/fund_session/session_detail_view.dart';
import 'package:provider/provider.dart';

import '../../helper/utils.dart';

class SessionViewWidget extends StatelessWidget {
  final FundSession session;

  const SessionViewWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          SlidableAction(
            onPressed: (context) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MemberEditWidget(),
              //   ),
              // );
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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SessionDetailWidget(session: session)),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 237, 44, 218),
                  child: Text('K${session.id}'),
                ),
                title: Text('Ngày mở hụi: ${Utils.dateFormat.format(session.takenDate)}\nKỳ 1\nThành viên hốt: ${session.takenSessionDetail.fundMember.nickName}\nThăm kêu: ${session.takenSessionDetail.predictedPrice}\nTiền hụi: ${session.takenSessionDetail.fundAmount}\nTrừ hoa hồng: ${session.takenSessionDetail.serviceCost}\nCòn lại: ${session.takenSessionDetail.remainPrice}', textAlign: TextAlign.right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FundSessionsWidget extends StatelessWidget {
  const FundSessionsWidget({super.key});

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
    );
  }
}
