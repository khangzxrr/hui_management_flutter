import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/mocking.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/service/login_service.dart';
import 'package:hui_management/view/dashboard_view.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});

  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    final navigate = Navigator.of(context);

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
                  decoration: const InputDecoration(labelText: 'Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.email()],
                  ),
                ),
                FormBuilderTextField(
                  key: _passwordFieldKey,
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Password'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                    onPressed: () async {
                      await EasyLoading.show(status: 'Đang đăng nhập...');

                      final authentication = await getIt<LoginService>().login("0862106650", "123123aaa");

                      log(authentication.toString());

                      if (authentication != null) {
                        authenticationProvider.setAuthentication(authentication);

                        navigate.pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const DashboardWidget(),
                          ),
                        );
                      }

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
