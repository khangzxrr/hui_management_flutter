import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/filters/general_fund_filter.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:hui_management/service/fund_service.dart';
import 'package:hui_management/view/fund/funds_view.dart';

@RoutePage()
class FundBelongToSubUserScreen extends StatefulWidget {
  final int subUserId;
  final String subUserName;

  const FundBelongToSubUserScreen({super.key, required this.subUserId, required this.subUserName});

  @override
  State<FundBelongToSubUserScreen> createState() => _FundBelongToSubUserScreenState();
}

class _FundBelongToSubUserScreenState extends State<FundBelongToSubUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí dây hụi'),
      ),
      body: FutureBuilder<List<GeneralFundModel>>(
        future: GetIt.I<FundService>().getAll(
          0,
          0,
          GeneralFundFilter(bySubuserId: widget.subUserId),
        ),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Có ${snapshot.data!.length} dây hụi mà ${widget.subUserName} tham gia'),
                ),
                ...snapshot.data!
                    .map(
                      (e) => SingleFundScreen(fund: e, parentContext: context),
                    )
                    .toList(),
              ],
            );
          }

          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('Có lỗi xảy ra, nhấn vào đây để thử lại')),
            );
          }
          return const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          );
        }),
      ),
    );
  }
}
