import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hui_management/helper/mocking.dart';

class MemberEditWidget extends StatelessWidget {
  MemberEditWidget({super.key});

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
                  decoration: const InputDecoration(labelText: 'Tên thành viên'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ), 
                FormBuilderTextField(
                  key: _bankNumberFieldKey,
                  name: 'bankNumber',
                  decoration: const InputDecoration(labelText: 'Số tài khoản'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderTextField(
                  key: _bankNameFieldKey,
                  name: 'bankName',
                  decoration: const InputDecoration(labelText: 'Bank name'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _addressFieldKey,
                  name: 'address',
                  decoration: const InputDecoration(labelText: 'Địa chỉ thành viên'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _phonenumberFieldKey,
                  name: 'phonenumber',
                  decoration: const InputDecoration(labelText: 'Số điện thoại thành viên'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderTextField(
                  key: _emailFieldKey,
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.email()],
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
                FormBuilderTextField(
                  key: _additionalFieldKey,
                  name: 'additional',
                  decoration: const InputDecoration(labelText: 'additional'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [],
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                    onPressed: () async {
                      print('hi!');
                      print(_formKey.currentState?.isValid);
                    },
                    child: const Text('Đăng kí thành viên mới'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
