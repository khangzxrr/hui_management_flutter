import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/filters/subuser_filter.dart';
import 'package:hui_management/model/sub_user_with_payment_report.dart';
import 'package:hui_management/provider/sub_users_with_payment_report_provider.dart';
import 'package:hui_management/view/abstract_view/infinity_scroll_widget.dart';
import 'package:provider/provider.dart';

import '../../helper/dialog.dart';
import '../../helper/utils.dart';
import '../../provider/payment_provider.dart';
import '../../routes/app_route.dart';

class SingleMemberScreen extends StatelessWidget {
  final SubUserWithPaymentReport subUserReports;

  const SingleMemberScreen({super.key, required this.subUserReports});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: subUserReports.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: imageProvider, fit: BoxFit.scaleDown),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        const Text('Tên: '),
                        AutoSizeText(
                          subUserReports.name,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Nick name: '),
                        AutoSizeText(
                          subUserReports.nickName,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text('Tổng tiền cần ${(subUserReports.totalProcessingAmount > 0) ? 'thu' : 'chi'}:  '),
                        AutoSizeText(
                          '${Utils.moneyFormat.format(subUserReports.totalProcessingAmount.abs())}đ',
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Còn nợ: '),
                        AutoSizeText(
                          '${Utils.moneyFormat.format(subUserReports.totalDebtAmount.abs())}đ',
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
          await Provider.of<PaymentProvider>(context, listen: false).getPayments(subUserReports.id).match((l) {
            log(l);
            DialogHelper.showSnackBar(context, 'Lỗi khi lấy bill thanh toán');
          }, (r) => context.router.push(PaymentListOfUserRoute(user: subUserReports))).run();
        },
      ),
    );
  }
}

@RoutePage()
class MultiplePaymentMembersScreen extends StatelessWidget {
  const MultiplePaymentMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subuserProvider = Provider.of<SubUserWithPaymentReportProvider>(context, listen: true);

    final convertedToInfinityScrollFilters = SubUserFilter().convertToInfinityScrollFilters();

    return InfinityScrollWidget<SubUserWithPaymentReport>(
      paginatedProvider: subuserProvider,
      filters: convertedToInfinityScrollFilters,
      alwaysOnFilters: SubUserFilter().convertAlwaysOnFilterToInfinityScrollFilters(),
      widgetItemFactory: (subuserWithPaymentReport) => SingleMemberScreen(subUserReports: subuserWithPaymentReport),
    );
  }
}
