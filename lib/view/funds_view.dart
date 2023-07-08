import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hui_management/view/fund_detail.dart';
import 'package:hui_management/view/fund_edit.dart';
import 'package:hui_management/view/fund_new_take_view.dart';

class FundWidget extends StatelessWidget {
  const FundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Lưu trữ',
          ),
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
            MaterialPageRoute(builder: (context) => const FundDetailWidget()),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 237, 44, 218),
                  child: const Text('1'),
                ),
                title: Text('Ngày mở hụi: 13/08/2022\nDây hụi 1,000.000đ\nThời gian khui: T2 mỗi tuần\nSố phần: 16\nGhi chú: đây là hụi abcxyz...'),
                subtitle: Chip(label: Text('12/16')),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FundNewTakeWidget()),
                      ),
                      icon: Icon(Icons.paid),
                      label: Text('Hốt'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FundsWidget extends StatelessWidget {
  const FundsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí danh sách dây hụi'),
      ),
      body: ListView(
        children: [
          FundWidget(),
          FundWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FundEditWidget(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
