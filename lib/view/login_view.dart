import 'dart:async';
import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/routes/app_route.dart';
import 'package:hui_management/service/login_service.dart';
import 'package:hui_management/service/setup_service.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AfterLayoutMixin<LoginScreen> {
  bool isLoading = false;

  //method that enable isLoading
  void enableLoading() {
    setState(() {
      isLoading = true;
    });
  }

  //method that disable isLoading
  void disableLoading() {
    setState(() {
      isLoading = false;
    });
  }

  final _formKey = GlobalKey<FormBuilderState>();

  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Đăng nhập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilderTextField(
                key: _emailFieldKey,
                name: 'email',
                initialValue: kReleaseMode ? '' : '0862106650',
                autofillHints: const [AutofillHints.username],
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()],
                ),
              ),
              FormBuilderTextField(
                key: _passwordFieldKey,
                name: 'password',
                autofillHints: const [AutofillHints.password],
                initialValue: kReleaseMode ? '' : '123123aaa',
                decoration: const InputDecoration(labelText: 'Mật khẩu'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()],
                ),
              ),
              const SizedBox(height: 30.0),
              (isLoading)
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState?.saveAndValidate();

                        if (!_formKey.currentState!.isValid) {
                          return;
                        }

                        enableLoading();

                        final authenticationEither = await GetIt.I<LoginService>().login(_emailFieldKey.currentState?.value as String, _passwordFieldKey.currentState?.value as String).run();

                        authenticationEither.match(
                          (error) {
                            if (error.contains('XMLHttpRequest error')) {
                              DialogHelper.showSnackBar(context, 'Lỗi kết nối đến máy chủ, vui lòng thử lại sau');
                            } else if (error.contains('Connection refused')) {
                              DialogHelper.showSnackBar(context, 'Không thể kết nối đến máy chủ, vui lòng thử lại sau');
                            } else {
                              DialogHelper.showSnackBar(context, 'Sai tài khoản hoặc mật khẩu');
                            }
                            disableLoading();
                          },
                          (authentication) async {
                            SetupService.setupAuthorizeServiced(authentication.token);
                            authenticationProvider.setAuthentication(authentication);

                            disableLoading();

                            context.router.pushAndPopUntil(const DashboardRoute(), predicate: (_) => false);
                          },
                        );
                      },
                      child: const Text('Đăng nhập')),
            ],
          ),
        ),
      ),
    );
  }
}
