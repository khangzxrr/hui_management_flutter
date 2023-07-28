import 'dart:async';
import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/routes/app_route.dart';
import 'package:hui_management/service/login_service.dart';
import 'package:hui_management/service/setup_service.dart';
import 'package:hui_management/view/dashboard_view.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AfterLayoutMixin<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  final getIt = GetIt.instance;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    //check login
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

    if (authenticationProvider.loadAuthenticationFromCache() != null) {
      SetupService.setupAuthorizeServiced(authenticationProvider.model!.token);
      //navigate.popAndPushNamed(DashboardWidget.routeName);
      context.router.navigate(const DashboardRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Đăng nhập'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  key: _emailFieldKey,
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Số điện thoại'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _passwordFieldKey,
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Mật khẩu'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                    onPressed: () async {
                      await EasyLoading.show(status: 'Đang đăng nhập...');

                      _emailFieldKey.currentState!.save();
                      _passwordFieldKey.currentState!.save();

                      if (_emailFieldKey.currentState?.value == null || _passwordFieldKey.currentState?.value == null) {
                        await EasyLoading.dismiss();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Vui lòng nhập tài khoản và mật khẩu'),
                        ));
                        return;
                      }

                      final authenticationEither = await getIt<LoginService>().login(_emailFieldKey.currentState?.value as String, _passwordFieldKey.currentState?.value as String).run();

                      authenticationEither.match(
                        (error) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Sai tài khoản hoặc mật khẩu'),
                        )),
                        (authentication) {
                          log(authentication.toString());
                          authenticationProvider.setAuthentication(authentication);

                          SetupService.setupAuthorizeServiced(authentication.token);

                          context.router.navigate(const DashboardRoute());
                        },
                      );

                      await EasyLoading.dismiss();
                    },
                    child: const Text('Đăng nhập'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
