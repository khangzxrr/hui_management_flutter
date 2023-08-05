
import 'package:cross_file/cross_file.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/constants.dart';

import '../service/image_service.dart';


class FormHelper {
  static String getRelativeUrlFromPicker(String? image) {
    if (image == null) {
      return '';
    }

    return image.replaceAll('${Constants.apiHostName}/', '');
  }

  static Future<String> upload(XFile file) async {
    return await GetIt.I<ImageService>().uploadImage(file);
  }
}
