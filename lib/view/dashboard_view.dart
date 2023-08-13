import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/authentication_model.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/provider/sub_users_provider.dart';
import 'package:provider/provider.dart';

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
      context.router.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
    }
  }
}

class DashboardInfo extends StatefulWidget {
  const DashboardInfo({super.key});

  @override
  State<DashboardInfo> createState() => _DashboardInfoState();
}

class _DashboardInfoState extends State<DashboardInfo> with AfterLayoutMixin<DashboardInfo> {
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
    return AutoTabsRouter(
      routes: const [
        DashboardInfoRoute(),
        MembersRoute(),
        MultipleFundsRoute(),
        MultiplePaymentMembersRoute(),
        MemberReportRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        // the passed child is technically our animated selected-tab page
        child: child,
      ),
      builder: (context, child) {
        final tabRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          floatingActionButton: tabRouter.activeIndex > 0 && tabRouter.activeIndex < 3
              ? FloatingActionButton(
                  onPressed: () {
                    if (tabRouter.current.name == MembersRoute.name) {
                      context.router.push(MemberEditRoute(isCreateNew: true, user: null));
                    } else if (tabRouter.current.name == MultipleFundsRoute.name) {
                      context.router.push(FundEditRoute(isNew: true, fund: null));
                    }
                  },
                  child: const Icon(Icons.add),
                )
              : null,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabRouter.activeIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) async {
              tabRouter.setActiveIndex(index);

              if (index == 3) {
                print('fetch payment members');
                await Provider.of<SubUsersProvider>(context, listen: false).getAllWithPaymentReport().run();
              } else if (index == 4) {
                print('fetch report');
                await Provider.of<UserReportProvider>(context, listen: false).getAllReport().run();
              } else if (index == 2) {
                print('fetch funds');
                await Provider.of<GeneralFundProvider>(context, listen: false).fetchFunds().run();
              } else if (index == 1) {
                print('fetch members');
                await Provider.of<SubUsersProvider>(context, listen: false).getAllUsers().run();
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Cá nhân'),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Thành viên'),
              BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Dây hụi'),
              BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Thanh toán'),
              BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Báo cáo'),
            ],
          ),
        );
      },
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    final usersProvider = Provider.of<SubUsersProvider>(context, listen: false);
    final generalFundProvider = Provider.of<GeneralFundProvider>(context, listen: false);

    await usersProvider.getAllUsers().run();

    await generalFundProvider.fetchFunds().run();

    print('trigger after first layout');
  }
}
