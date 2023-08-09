import 'dart:async';
import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/authentication_model.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/provider/sub_users_provider.dart';
import 'package:provider/provider.dart';

import '../helper/dialog.dart';
import '../provider/user_report_provider.dart';
import '../routes/app_route.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with AfterLayoutMixin<DashboardScreen> {
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: true); //must not listen to avoid infinite loop

    return Scaffold(
      appBar: AppBar(
        // // Here we take the value from the MyHomePage object that was created by
        // // the App.build method, and use it to set our appbar title.
        title: const Text('Menu quản lí hụi'),

        actions: [
          //setting icon button
          IconButton(
            onPressed: () {
              context.router.push(MemberEditRoute(isCreateNew: false, user: authenticationProvider.model!.subUser)).then((value) {
                if (value != null) {
                  authenticationProvider.setAuthentication(AuthenticationModel(subUser: value as SubUserModel, token: authenticationProvider.model!.token));
                }
              });
            },
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              authenticationProvider.clearAuthentication();
              context.router.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: (authenticationProvider.model != null)
          ? const DashboardInfo()
          : ElevatedButton(
              onPressed: () {
                if (context.router.canNavigateBack) {
                  context.router.navigate(const LoginRoute());
                } else {
                  context.router.popUntilRoot();
                }
              },
              child: const Text('Bạn không có quyền xem trang này, nhấn vào đây để đăng nhập lại'),
            ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false); //must not listen to avoid infinite loop

    if (authenticationProvider.model == null) {
      context.router.pushAndPopUntil(LoginRoute(), predicate: (_) => false);
    }
  }
}

class DashboardInfo extends StatefulWidget {
  const DashboardInfo({super.key});

  @override
  State<DashboardInfo> createState() => _DashboardInfoState();
}

class _DashboardInfoState extends State<DashboardInfo> {
  bool loading = false;

  void enableLoading() async {
    setState(() {
      loading = true;
    });
  }

  void disableLoading() async {
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: true); //must not listen to avoid infinite loop

    final usersProvider = Provider.of<SubUsersProvider>(context, listen: false);

    final generalFundProvider = Provider.of<GeneralFundProvider>(context, listen: false);

    final userReportProvider = Provider.of<UserReportProvider>(context, listen: false);

    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        loading ? const LinearProgressIndicator() : const SizedBox(),
        const SizedBox(height: 5, width: 5),
        SizedBox(
          width: 200,
          height: 200,
          child: CachedNetworkImage(
            imageUrl: authenticationProvider.model!.subUser.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: 100.0,
              height: 100.0,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.scaleDown),
              ),
            ),
            placeholder: (context, url) => const LinearProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 10, width: 10),
        Text(
          textAlign: TextAlign.center,
          authenticationProvider.model!.subUser.name,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5, width: 5),
        AutoSizeText(
          textAlign: TextAlign.center,
          authenticationProvider.model!.subUser.address,
          style: const TextStyle(fontSize: 15),
          maxLines: 1,
        ),
        const SizedBox(height: 5, width: 5),
        Text(
          textAlign: TextAlign.center,
          authenticationProvider.model!.subUser.phoneNumber,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 5, width: 5),
        Text(
          textAlign: TextAlign.center,
          '${authenticationProvider.model!.subUser.bankName} - ${authenticationProvider.model!.subUser.bankNumber}',
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 10, width: 15),
        ElevatedButton(
            onPressed: () {
              enableLoading();

              usersProvider.getAllUsers().match((l) {
                DialogHelper.showSnackBar(context, 'Có lỗi khi lấy danh sách thành viên');
                context.router.pop();
                disableLoading();
              }, (r) {
                disableLoading();
                context.router.push(const MembersRoute());
              }).run();
            },
            child: const Text('Quản lí người dùng')),
        const SizedBox(width: 30, height: 30),
        ElevatedButton(
            onPressed: () {
              enableLoading();

              generalFundProvider.fetchFunds().match(
                (l) {
                  disableLoading();
                  log(l);
                  DialogHelper.showSnackBar(context, 'Có lỗi xảy ra khi lấy danh sách dây hụi CODE: $l');
                },
                (r) {
                  disableLoading();
                  context.router.push(const MultipleFundsRoute());
                },
              ).run();
            },
            child: const Text('Quản lí dây hụi')),
        const SizedBox(
          width: 30,
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            enableLoading();

            usersProvider.getAllWithPaymentReport().match(
              (l) {
                disableLoading();
                log(l);
                DialogHelper.showSnackBar(context, 'Có lỗi xảy ra khi lấy danh sách thành viên CODE: $l');
              },
              (r) {
                disableLoading();
                context.router.push(MultiplePaymentMembersRoute(users: r));
              },
            ).run();
          },
          child: const Text('Quản lí thanh toán'),
        ),
        const SizedBox(width: 30, height: 30),
        ElevatedButton(
          onPressed: () {
            enableLoading();

            userReportProvider.getAllReport().match(
              (l) {
                disableLoading();
                log(l);
                DialogHelper.showSnackBar(context, 'Có lỗi xảy ra khi lấy báo cáo thành viên CODE: $l');
              },
              (r) {
                disableLoading();
                context.router.push(MemberReportRoute(userReportModels: r));
              },
            ).run();
          },
          child: const Text('Báo cáo thành viên'),
        ),
      ],
    );
  }
}
