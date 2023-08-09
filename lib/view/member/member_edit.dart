import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/provider/sub_users_provider.dart';
import 'package:provider/provider.dart';

import '../../helper/formHelper.dart';

@RoutePage()
class MemberEditScreen extends StatefulWidget {
  final bool isCreateNew;
  final SubUserModel? user;

  const MemberEditScreen({super.key, required this.isCreateNew, required this.user});

  @override
  State<MemberEditScreen> createState() => _MemberEditScreenState();
}

class _MemberEditScreenState extends State<MemberEditScreen> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormBuilderState>();

  final _identityFieldKey = GlobalKey<FormBuilderFieldState>();

  final _identityCreateDateFieldKey = GlobalKey<FormBuilderFieldState>();

  final _identityAddressFieldKey = GlobalKey<FormBuilderFieldState>();

  final _nameFieldKey = GlobalKey<FormBuilderFieldState>();

  final _nicknameFieldKey = GlobalKey<FormBuilderFieldState>();

  final _addressFieldKey = GlobalKey<FormBuilderFieldState>();

  final _bankNumberFieldKey = GlobalKey<FormBuilderFieldState>();

  final _bankNameFieldKey = GlobalKey<FormBuilderFieldState>();

  final _phonenumberFieldKey = GlobalKey<FormBuilderFieldState>();

  final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  final _additionalFieldKey = GlobalKey<FormBuilderFieldState>();

  final _photoFieldKey = GlobalKey<FormBuilderFieldState>();

  final _identityFrontImageKey = GlobalKey<FormBuilderFieldState>();

  final _identityBackImageKey = GlobalKey<FormBuilderFieldState>();

  void makeRequest(SubUserModel user, SubUsersProvider provider) async {}

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    final usersProvider = Provider.of<SubUsersProvider>(context, listen: false);

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
                FormBuilderImagePicker(
                    name: 'avatar',
                    key: _photoFieldKey,
                    decoration: const InputDecoration(labelText: 'Pick Photos'),
                    availableImageSources: const [ImageSourceOption.gallery],
                    maxImages: 1,
                    initialValue: [widget.isCreateNew ? Constants.randomAvatarPath : widget.user!.imageUrl],
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()],
                    )),
                FormBuilderTextField(
                  key: _nameFieldKey,
                  name: 'name',
                  initialValue: widget.isCreateNew ? "" : widget.user!.name,
                  decoration: const InputDecoration(labelText: 'Tên thành viên'),
                  autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _nicknameFieldKey,
                  name: 'nickname',
                  initialValue: widget.isCreateNew ? "" : widget.user!.nickName,
                  decoration: const InputDecoration(labelText: 'Biệt danh thành viên (zalo, fb,...)'),
                  autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _bankNameFieldKey,
                  name: 'bankName',
                  initialValue: widget.isCreateNew ? "" : widget.user!.bankName,
                  decoration: const InputDecoration(labelText: 'Bank name'),
                  autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _bankNumberFieldKey,
                  name: 'bankNumber',
                  initialValue: widget.isCreateNew ? "" : widget.user!.bankNumber,
                  decoration: const InputDecoration(labelText: 'Số tài khoản'),
                  autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderTextField(
                  key: _addressFieldKey,
                  name: 'address',
                  decoration: const InputDecoration(labelText: 'Địa chỉ thành viên'),
                  initialValue: widget.isCreateNew ? "" : widget.user!.address,
                  autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _phonenumberFieldKey,
                  name: 'phonenumber',
                  initialValue: widget.isCreateNew ? "" : widget.user!.phoneNumber,
                  decoration: const InputDecoration(labelText: 'Số điện thoại thành viên'),
                  autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                // FormBuilderTextField(
                //   key: _passwordFieldKey,
                //   name: 'password',
                //   initialValue: widget.isCreateNew ? "" : widget.user!.password,
                //   decoration: const InputDecoration(labelText: 'Mật khẩu'),
                //   autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                //   validator: FormBuilderValidators.compose(
                //     [FormBuilderValidators.required()],
                //   ),
                // ),
                FormBuilderTextField(
                  key: _additionalFieldKey,
                  name: 'additional',
                  initialValue: widget.isCreateNew ? "" : widget.user!.additionalInfo,
                  decoration: const InputDecoration(labelText: 'Thông tin thêm'),
                  autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [],
                  ),
                ),
                FormBuilderTextField(
                  key: _identityFieldKey,
                  name: 'identity',
                  initialValue: widget.isCreateNew ? "" : widget.user!.identity,
                  decoration: const InputDecoration(labelText: 'CMND/CCCD'),
                  autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderDateTimePicker(
                  key: _identityCreateDateFieldKey,
                  name: 'identityCreateDate',
                  inputType: InputType.date,
                  decoration: const InputDecoration(labelText: 'Ngày cấp CMND/CCCD'),
                  initialValue: widget.isCreateNew ? DateTime.now() : widget.user!.identityCreateDate,
                  autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _identityAddressFieldKey,
                  name: 'identityAddress',
                  initialValue: widget.isCreateNew ? "" : widget.user!.identityAddress,
                  decoration: const InputDecoration(labelText: 'Nơi cấp CMND/CCCD'),
                  autovalidateMode: widget.isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderImagePicker(
                  name: 'identityFrontImage',
                  key: _identityFrontImageKey,
                  decoration: const InputDecoration(labelText: 'Anh mặt trước CMND/CCCD'),
                  availableImageSources: const [ImageSourceOption.gallery],
                  initialValue: [widget.isCreateNew ? null : widget.user!.identityImageFrontUrl],
                  maxImages: 1,
                ),
                FormBuilderImagePicker(
                  name: 'identityBackImage',
                  key: _identityBackImageKey,
                  decoration: const InputDecoration(labelText: 'Anh mặt sau CMND/CCCD'),
                  availableImageSources: const [ImageSourceOption.gallery],
                  initialValue: [widget.isCreateNew ? null : widget.user!.identityImageBackUrl],
                  maxImages: 1,
                ),
                const SizedBox(height: 30.0),
                (isLoading)
                    ? const CircularProgressIndicator()
                    : FilledButton(
                        onPressed: () async {
                          _formKey.currentState?.saveAndValidate();

                          if (!_formKey.currentState!.isValid) {
                            return;
                          }

                          setState(() {
                            isLoading = true;
                          });

                          List<dynamic> avatar = _photoFieldKey.currentState!.value;

                          String imageUrl = '';

                          if (avatar.first is XFile) {
                            try {
                              imageUrl = await FormHelper.upload(avatar.first);
                            } catch (e) {
                              DialogHelper.showSnackBar(context, 'Lỗi khi tải ảnh lên CODE $e');
                            }
                          } else {
                            imageUrl = avatar.first;
                          }

                          List<dynamic> identityFrontImages = _identityFrontImageKey.currentState!.value;
                          String? identityFrontImageUrl;

                          if (identityFrontImages.isNotEmpty && identityFrontImages.first is XFile) {
                            try {
                              identityFrontImageUrl = await FormHelper.upload(identityFrontImages.first);
                            } catch (e) {
                              DialogHelper.showSnackBar(context, 'Lỗi khi tải ảnh lên CODE: $e');
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                          List<dynamic> identityBackImages = _identityBackImageKey.currentState!.value;
                          String? identityBackImageUrl;

                          if (identityBackImages.isNotEmpty && identityBackImages.first is XFile) {
                            try {
                              identityBackImageUrl = await FormHelper.upload(identityBackImages.first);
                            } catch (e) {
                              DialogHelper.showSnackBar(context, 'Lỗi khi tải ảnh lên CODE: $e');
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }

                          final modifyUser = SubUserModel(
                            id: widget.isCreateNew ? 0 : widget.user!.id,
                            imageUrl: imageUrl,
                            name: _nameFieldKey.currentState!.value,
                            nickName: _nicknameFieldKey.currentState!.value,
                            identity: _identityFieldKey.currentState!.value,
                            identityCreateDate: _identityCreateDateFieldKey.currentState!.value!,
                            identityAddress: _identityAddressFieldKey.currentState!.value,
                            //password: _passwordFieldKey.currentState!.value,
                            phoneNumber: _phonenumberFieldKey.currentState!.value,
                            bankName: _bankNameFieldKey.currentState!.value,
                            bankNumber: _bankNumberFieldKey.currentState!.value,
                            address: _addressFieldKey.currentState!.value,
                            additionalInfo: _additionalFieldKey.currentState!.value,
                            identityImageFrontUrl: identityFrontImageUrl,
                            identityImageBackUrl: identityBackImageUrl,
                          );

                          if (widget.isCreateNew) {
                            usersProvider.createUser(modifyUser).andThen(() => usersProvider.getAllUsers()).match(
                              (l) {
                                log(l);
                                DialogHelper.showSnackBar(context, 'Có lỗi xảy ra khi tạo thành viên mới CODE: $l');
                              },
                              (r) {
                                log('ok');
                                DialogHelper.showSnackBar(context, 'Tạo thành viên mới thành công');
                                navigator.pop();
                              },
                            ).run();
                          } else {
                            usersProvider.updateUser(modifyUser).andThen(() => usersProvider.getAllUsers()).match(
                              (l) {
                                log(l);
                                DialogHelper.showSnackBar(context, 'Có lỗi xảy ra khi cập nhật thông tin CODE: $l');
                              },
                              (r) {
                                log('ok');
                                DialogHelper.showSnackBar(context, 'Cập nhật thành viên thành công');
                                navigator.pop(modifyUser);
                              },
                            ).run();
                          }

                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Text(widget.isCreateNew ? 'Đăng kí thành viên mới' : 'Lưu chỉnh sửa'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
