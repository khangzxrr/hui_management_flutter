import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hui_management/view/fund_detail.dart';
import 'package:hui_management/view/session_detail.dart';

class SessionViewWidget extends StatelessWidget {
  const SessionViewWidget({super.key});

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
            backgroundColor: Color.fromARGB(255, 31, 132, 248),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Chỉnh sửa',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Card(
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SessionDetailWidget()),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 237, 44, 218),
                  child: const Text('K1'),
                ),
                title: Text('Ngày mở hụi: 21/08/2022\nKỳ 1\nThành viên hốt: Đoàn văn tiến\nThăm kêu: 50.000\nTiền hụi: 102.999.999', textAlign: TextAlign.right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
