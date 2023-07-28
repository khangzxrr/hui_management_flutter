import 'dart:developer';

import 'package:cross_file/cross_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:hui_management/provider/users_provider.dart';
import 'package:hui_management/service/image_service.dart';
import 'package:hui_management/service/user_service.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as image_lib;

import '../../helper/utils.dart';

class MemberEditWidget extends StatelessWidget {
  final bool isCreateNew;
  final UserModel? user;

  MemberEditWidget({super.key, required this.isCreateNew, required this.user});

  final _formKey = GlobalKey<FormBuilderState>();

  final _identityFieldKey = GlobalKey<FormBuilderFieldState>();
  final _identityCreateDateFieldKey = GlobalKey<FormBuilderFieldState>();
  final _identityAddressFieldKey = GlobalKey<FormBuilderFieldState>();

  final _nameFieldKey = GlobalKey<FormBuilderFieldState>();

  final _addressFieldKey = GlobalKey<FormBuilderFieldState>();

  final _bankNumberFieldKey = GlobalKey<FormBuilderFieldState>();
  final _bankNameFieldKey = GlobalKey<FormBuilderFieldState>();

  final _phonenumberFieldKey = GlobalKey<FormBuilderFieldState>();

  final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  final _additionalFieldKey = GlobalKey<FormBuilderFieldState>();

  final _photoFieldKey = GlobalKey<FormBuilderFieldState>();

  final _identityFrontImageKey = GlobalKey<FormBuilderFieldState>();
  final _identityBackImageKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    if (!isCreateNew) {
      GetIt.I<ImageService>().getImagePathFromFireStorage(user!.imageUrl).then((value) => _photoFieldKey.currentState!.didChange([value]));
    }
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
                ),
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
                  key: _passwordFieldKey,
                  name: 'password',
                  initialValue: isCreateNew ? "" : user!.password,
                  decoration: const InputDecoration(labelText: 'Mật khẩu'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _additionalFieldKey,
                  name: 'additional',
                  initialValue: isCreateNew ? "" : user!.additionalInfo,
                  decoration: const InputDecoration(labelText: 'Thông tin thêm'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [],
                  ),
                ),
                FormBuilderTextField(
                  key: _identityFieldKey,
                  name: 'identity',
                  initialValue: isCreateNew ? "" : user!.identity,
                  decoration: const InputDecoration(labelText: 'CMND/CCCD'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderDateTimePicker(
                  key: _identityCreateDateFieldKey,
                  name: 'identityCreateDate',
                  inputType: InputType.date,
                  decoration: const InputDecoration(labelText: 'Ngày cấp CMND/CCCD'),
                  initialValue: isCreateNew ? DateTime.now() : user!.identityCreateDate,
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _identityAddressFieldKey,
                  name: 'identityAddress',
                  initialValue: isCreateNew ? "" : user!.identityAddress,
                  decoration: const InputDecoration(labelText: 'Nơi cấp CMND/CCCD'),
                  autovalidateMode: isCreateNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderImagePicker(
                  name: 'identityFrontImage',
                  key: _identityFrontImageKey,
                  decoration: const InputDecoration(labelText: 'Anh mặt trước CMND/CCCD'),
                  availableImageSources: const [ImageSourceOption.gallery],
                  maxImages: 1,
                ),
                FormBuilderImagePicker(
                  name: 'identityBackImage',
                  key: _identityBackImageKey,
                  decoration: const InputDecoration(labelText: 'Anh mặt sau CMND/CCCD'),
                  availableImageSources: const [ImageSourceOption.gallery],
                  maxImages: 1,
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.isValid) {
                        return;
                      }

                      List<dynamic>? images = _photoFieldKey.currentState!.value;

                      String imageUrl = isCreateNew ? Constants.randomAvatarPath : user!.imageUrl;

                      if (images != null && images.isNotEmpty && images[0] is XFile) {
                        final file = images[0] as XFile;
                        final bytes = await file.readAsBytes();
                        image_lib.Image image = image_lib.decodeImage(bytes)!;
                        //size image to 120
                        image_lib.Image resizedImage = image_lib.copyResize(image, width: 300);

                        final firebaseStorage = FirebaseStorage.instanceFor(bucket: 'gs://test-1d90e.appspot.com').ref('public');

                        imageUrl = '${Utils.getRandomString(30)}.jpg';
                        final imageRef = firebaseStorage.child(imageUrl);

                        await imageRef.putData(image_lib.encodeJpg(resizedImage), SettableMetadata(contentType: 'image/jpg'));
                      }

                      final modifyUser = UserModel(
                        id: isCreateNew ? 0 : user!.id,
                        imageUrl: imageUrl,
                        name: _nameFieldKey.currentState!.value,
                        identity: _identityFieldKey.currentState!.value,
                        identityCreateDate: _identityCreateDateFieldKey.currentState!.value!,
                        identityAddress: _identityAddressFieldKey.currentState!.value,
                        password: _passwordFieldKey.currentState!.value,
                        phonenumber: _phonenumberFieldKey.currentState!.value,
                        bankname: _bankNameFieldKey.currentState!.value,
                        banknumber: _bankNumberFieldKey.currentState!.value,
                        address: _addressFieldKey.currentState!.value,
                        additionalInfo: _additionalFieldKey.currentState!.value,
                        identityImageFrontUrl: "",
                        identityImageBackUrl: "",
                      );

                      if (isCreateNew) {
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
