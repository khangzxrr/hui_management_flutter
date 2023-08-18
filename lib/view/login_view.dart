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

  final getIt = GetIt.instance;

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

                        final authenticationEither = await getIt<LoginService>().login(_emailFieldKey.currentState?.value as String, _passwordFieldKey.currentState?.value as String).run();

                        authenticationEither.match(
                          (error) {
                            log(error);
                            if (error.contains('XMLHttpRequest error')) {
                              DialogHelper.showSnackBar(context, 'Lỗi kết nối đến máy chủ, vui lòng thử lại sau');
                            } else {
                              DialogHelper.showSnackBar(context, 'Sai tài khoản hoặc mật khẩu');
                            }
                            disableLoading();
                          },
                          (authentication) {
                            log(authentication.toString());
                            authenticationProvider.setAuthentication(authentication);

                            SetupService.setupAuthorizeServiced(authentication.token);

                            disableLoading();

                            context.router.pushAndPopUntil(const DashboardRoute(), predicate: (_) => false);
                          },
                        );
                      },
                      child: const Text('Đăng nhập')),
              //const Text(
              //    '- [Chưa làm]  Cập nhật thêm hình ảnh khi thanh toán bill\n- [x]  Hiển thị loading để người dùng biết đang load dữ liệu\n- [x]  Sửa lỗi không tự ra danh sách thành viên khi nhấn lưu\n- [x]  Cập nhật CMND, ảnh CMND, nick name cho thành viên\n- [x]  Thêm chức năng nhấn vào sửa thông tin thành viên\n- [x]  Hiển thị tổng số thành viên\n- [x]  lọc theo tên, sđt, nick name,\n- [x]  sửa lỗi hiện thị con cú ở quản lí thành viên\n- [x]  sửa lỗi đơ khi không nhập ngày ghi chú khi tạo dây hụi\n- [x]  format lại giao diện ở xem kì hụi\n- [x]  sửa chi tiết kì hụi chưa cập nhật tên\n- [x]  format lại chi tiết kì hụi\n- [x]  thu nhỏ bảng dây hụi ở bill thanh toán\n- [x]  sửa lỗi bị bôi trắng các tab ở bill\n- [x]  Thông tin chỉ hiển thị trên 1 hàng ở dashboard\n- [x]  Sửa đếm thứ tự dây hụi thành màu xanh và KHÔNG gộp nó với những dây đã được lưu trữ\n- [x]  format lại thông tin dây hụi ở danh sách dây hụi\n- [x]  format lại thông tin ở chi tiết dây hụi\n- [x]  format lại thống nhất chữ hoa hoặc thưởng ở chi tiết dây hụi\n- [x]  format lại mỗi thông tin một hàng ở bill thanh toán, canh thẳng hàng giá trị\n- [x]  Sửa title bill bị ẩn … khi xem trên điện thoại\n- [x]  Sắp xếp lại bảng dây hụi ở bill Kỳ => Ngày khui => Tên hụi => Tiền đóng => Tiền hốt => Ngày bắt đầu => Ngày kết thúc'),
            ],
          ),
        ),
      ),
    );
  }
}
