import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/fund_model.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/view/fund_detail.dart';
import 'package:hui_management/view/fund_edit.dart';
import 'package:hui_management/view/fund_new_take_view.dart';
import 'package:provider/provider.dart';

class FundWidget extends StatelessWidget {
  final Fund fund;

  const FundWidget({super.key, required this.fund});

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FundEditWidget(isNew: false, fund: fund),
                ),
              );
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
                  backgroundColor: const Color.fromARGB(255, 237, 44, 218),
                  child: Text('${fund.id}'),
                ),
                title: Text('Tên: ${fund.name}\nNgày mở hụi: ${fund.openDateText}\nDây hụi ${fund.fundPrice}.000đ\nHoa hồng: ${fund.serviceCost}.000đ\nSố phần: ${fund.membersCount}\nNgày tạo hụi: ${Utils.dateFormat.format(fund.openDate)}'),
                subtitle: Chip(label: Text('Kì ${fund.sessionsCount}/${fund.membersCount}')),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FundNewTakeWidget(isNew: true, fund: null)),
                      ),
                      icon: const Icon(Icons.paid),
                      label: const Text('Hốt'),
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
    final fundProvider = Provider.of<FundProvider>(context);

    List<Widget> fundWidgets = fundProvider
        .getFunds()
        .map(
          (e) => FundWidget(fund: e),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí danh sách dây hụi'),
      ),
      body: ListView(children: fundWidgets),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FundEditWidget(isNew: true, fund: null),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
