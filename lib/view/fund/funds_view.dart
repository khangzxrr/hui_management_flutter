import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/service/fund_service.dart';
import 'package:provider/provider.dart';

import '../../routes/app_route.dart';
import 'fund_edit.dart';

class SingleFundScreen extends StatelessWidget {
  final GeneralFundModel fund;

  const SingleFundScreen({super.key, required this.fund});

  @override
  Widget build(BuildContext context) {
    final generalFundProvider = Provider.of<GeneralFundProvider>(context, listen: false);
    final fundProvider = Provider.of<FundProvider>(context, listen: false);

    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) async {
              final isSuccessEither = GetIt.I<FundService>().archived(fund.id, true);

              isSuccessEither.match((l) => {}, (r) {
                generalFundProvider.removeFund(fund);
              }).run();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Lưu trữ',
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FundEditScreen(isNew: false, fund: fund),
                ),
              );
            },
            backgroundColor: const Color.fromARGB(255, 31, 132, 248),
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
          onTap: () {
            fundProvider
                .getFund(fund.id)
                .match(
                  (l) => log(l.toString()),
                  (r) => context.router.push(const FundDetailRoute()),
                )
                .run();
            ;
          },
          //get primary color of context

          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text('D${generalFundProvider.getFunds().indexOf(fund) + 1}'),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tên dây hụi: ', textAlign: TextAlign.left),
                        Text('Ngày khui hụi: ', textAlign: TextAlign.left),
                        Text('Mệnh giá: ', textAlign: TextAlign.left),
                        Text('Hoa hồng: ', textAlign: TextAlign.left),
                        Text('Ngày tạo dây hụi: ', textAlign: TextAlign.left),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(fund.name, textAlign: TextAlign.right),
                        Text(fund.openDateText, textAlign: TextAlign.right),
                        Text('${Utils.moneyFormat.format(fund.fundPrice)}đ', textAlign: TextAlign.right),
                        Text('${Utils.moneyFormat.format(fund.serviceCost)}đ', textAlign: TextAlign.right),
                        Text(Utils.dateFormat.format(fund.openDate), textAlign: TextAlign.right),
                      ],
                    ),
                  ],
                ),
                subtitle: Chip(label: Text('Kì ${fund.sessionsCount}/${fund.membersCount}')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@RoutePage()
class MultipleFundsScreen extends StatefulWidget {
  const MultipleFundsScreen({super.key});

  @override
  State<MultipleFundsScreen> createState() => _MultipleFundsScreenState();
}

class _MultipleFundsScreenState extends State<MultipleFundsScreen> {
  String filterText = '';

  @override
  Widget build(BuildContext context) {
    final generalFundProvider = Provider.of<GeneralFundProvider>(context);

    List<Widget> generalFundWigets = generalFundProvider
        .getFunds()
        .where((f) => f.toString().toLowerCase().replaceAll(' ', '').contains(filterText.toLowerCase()))
        .map(
          (e) => SingleFundScreen(fund: e),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí danh sách dây hụi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Text('Tổng số dây hụi: ${generalFundProvider.getFunds().length}'),
          const SizedBox(
            width: 8,
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tìm kiếm hụi (tên,...))',
                  ),
                  onChanged: (text) {
                    setState(() {
                      filterText = text;
                    });
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    filterText = '';
                  });
                },
                icon: const Icon(Icons.clear),
              ),
            ],
          ),
          ...generalFundWigets,
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(FundEditRoute(isNew: true, fund: null)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
