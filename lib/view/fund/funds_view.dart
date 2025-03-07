import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hui_management/filters/general_fund_filter.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/provider/sub_users_with_payment_report_provider.dart';
import 'package:hui_management/view/abstract_view/infinity_scroll_widget.dart';
import 'package:hui_management/view/fund/fund_info_widget.dart';
import 'package:provider/provider.dart';

import '../../routes/app_route.dart';
import 'fund_edit.dart';

class SingleFundScreen extends StatelessWidget {
  final GeneralFundModel fund;
  final BuildContext parentContext;

  const SingleFundScreen({super.key, required this.fund, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    final generalFundProvider = Provider.of<GeneralFundProvider>(context, listen: false);
    final fundProvider = Provider.of<FundProvider>(context, listen: false);
    final subUserWithPaymentReportProvider = Provider.of<SubUserWithPaymentReportProvider>(context, listen: false);

    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          SlidableAction(
            onPressed: (context) {
              DialogHelper.showConfirmDialog(parentContext, 'Xác nhận xóa', 'Bạn có chắc chắn muốn xóa dây hụi này, dây hụi bạn xóa sẽ không thể khôi phục lại.').then(
                (result) async {
                  if (result == null || !result) return;

                  final isSuccessEither = await fundProvider
                      .removeFund(fund.id)
                      .andThen(
                        () => subUserWithPaymentReportProvider.refreshPagingTaskEither(),
                      )
                      .run();

                  isSuccessEither.match((l) {
                    log(l);
                    DialogHelper.showSnackBar(parentContext, 'Có lỗi xảy ra, Xóa dây hụi thất bại');
                  }, (r) {
                    DialogHelper.showSnackBar(parentContext, 'Xóa dây hụi thành công');
                    generalFundProvider.removeFund(fund);
                  });
                },
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
          // A SlidableAction can have an icon and/or a label.
          // SlidableAction(
          //   onPressed: (context) async {
          //     final isSuccessEither = GetIt.I<FundService>().archived(fund.id, true);

          //     isSuccessEither.match((l) => {}, (r) {
          //       generalFundProvider.removeFund(fund);
          //     }).run();
          //   },
          //   backgroundColor: const Color.fromARGB(255, 20, 134, 255),
          //   foregroundColor: Colors.white,
          //   icon: Icons.archive,
          // ),
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FundEditScreen(isNew: false, fund: fund),
                ),
              );
            },
            backgroundColor: const Color.fromARGB(255, 255, 134, 20),
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: InkWell(
            onTap: () async {
              await fundProvider
                  .getFund(fund.id)
                  .match(
                    (l) => log(l.toString()),
                    (r) => context.router.push(const FundDetailRoute()),
                  )
                  .run();
            },
            child: Column(
              children: <Widget>[
                ListTile(
                  dense: true,
                  title: FundInfoWidget(fund: fund),
                  subtitle: Chip(label: Text('Kì ${fund.sessionsCount}/${fund.membersCount}')),
                ),
              ],
            ),
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
  @override
  Widget build(BuildContext context) {
    final generalFundProvider = Provider.of<GeneralFundProvider>(context, listen: true);

    return InfinityScrollWidget(
      paginatedProvider: generalFundProvider,
      widgetItemFactory: (fund) => SingleFundScreen(fund: fund, parentContext: context),
      filters: GeneralFundFilter().convertToInfinityScrollFilters(),
    );
  }
}
