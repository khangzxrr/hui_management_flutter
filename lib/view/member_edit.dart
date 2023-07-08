import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:hui_management/provider/users_provider.dart';
import 'package:hui_management/service/user_service.dart';
import 'package:provider/provider.dart';

class MemberEditWidget extends StatelessWidget {
  late final bool isCreateNew;
  late UserModel? user;

  MemberEditWidget({super.key, required this.isCreateNew, required this.user});

  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  final _nameFieldKey = GlobalKey<FormBuilderFieldState>();

  final _addressFieldKey = GlobalKey<FormBuilderFieldState>();

  final _bankNumberFieldKey = GlobalKey<FormBuilderFieldState>();
  final _bankNameFieldKey = GlobalKey<FormBuilderFieldState>();

  final _phonenumberFieldKey = GlobalKey<FormBuilderFieldState>();

  final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  final _additionalFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí thành viên'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  key: _nameFieldKey,
                  name: 'name',
                  initialValue: isCreateNew ? "" : user!.name,
                  decoration: const InputDecoration(labelText: 'Tên thành viên'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _bankNameFieldKey,
                  name: 'bankName',
                  initialValue: isCreateNew ? "" : user!.bankname,
                  decoration: const InputDecoration(labelText: 'Bank name'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _bankNumberFieldKey,
                  name: 'bankNumber',
                  initialValue: isCreateNew ? "" : user!.banknumber,
                  decoration: const InputDecoration(labelText: 'Số tài khoản'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderTextField(
                  key: _addressFieldKey,
                  name: 'address',
                  decoration: const InputDecoration(labelText: 'Địa chỉ thành viên'),
                  initialValue: isCreateNew ? "" : user!.address,
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _phonenumberFieldKey,
                  name: 'phonenumber',
                  initialValue: isCreateNew ? "" : user!.phonenumber,
                  decoration: const InputDecoration(labelText: 'Số điện thoại thành viên'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderTextField(
                  key: _emailFieldKey,
                  name: 'email',
                  initialValue: isCreateNew ? "" : user!.email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.email()],
                  ),
                ),
                FormBuilderTextField(
                  key: _passwordFieldKey,
                  name: 'password',
                  initialValue: isCreateNew ? "" : user!.password,
                  decoration: const InputDecoration(labelText: 'Password'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _additionalFieldKey,
                  name: 'additional',
                  initialValue: isCreateNew ? "" : user!.additionalInfo,
                  decoration: const InputDecoration(labelText: 'additional'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [],
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.isValid) {
                        return;
                      }

                      if (isCreateNew) {
                        final user = await GetIt.I<UserService>().createNew(
                          name: _nameFieldKey.currentState!.value,
                          password: _passwordFieldKey.currentState!.value,
                          email: _emailFieldKey.currentState!.value,
                          phonenumber: _phonenumberFieldKey.currentState!.value,
                          bankname: _bankNameFieldKey.currentState!.value,
                          banknumber: _bankNumberFieldKey.currentState!.value,
                          address: _addressFieldKey.currentState!.value,
                          additionalInfo: _additionalFieldKey.currentState!.value,
                        );

                        if (user == null) {
                          return;
                        }

                        usersProvider.addUser(user);
                      } else {
                        
                        final updatedUser = await GetIt.I<UserService>().update(
                          id: user!.id,
                          name: _nameFieldKey.currentState!.value,
                          password: _passwordFieldKey.currentState!.value,
                          email: _emailFieldKey.currentState!.value,
                          phonenumber: _phonenumberFieldKey.currentState!.value,
                          bankname: _bankNameFieldKey.currentState!.value,
                          banknumber: _bankNumberFieldKey.currentState!.value,
                          address: _addressFieldKey.currentState!.value,
                          additionalInfo: _additionalFieldKey.currentState!.value,
                        );

                        if (user == null) {
                          return;
                        }

                        usersProvider.updateUser(updatedUser!);
                      }

                      navigator.pop();
                    },
                    child: Text(isCreateNew ? 'Đăng kí thành viên mới' : 'Lưu chỉnh sửa'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
