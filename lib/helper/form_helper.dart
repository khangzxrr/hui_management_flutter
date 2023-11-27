import 'package:cross_file/cross_file.dart';
import 'package:fpdart/fpdart.dart';
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


  static TaskEither<Exception, String> upload(XFile file) => TaskEither.tryCatch(() async => await GetIt.I<ImageService>().uploadImage(file), (error, stackTrace) => error as Exception);
}
