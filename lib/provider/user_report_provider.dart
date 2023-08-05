import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

import '../model/user_report_model.dart';
import '../service/user_report_service.dart';

class UserReportProvider with ChangeNotifier {
  TaskEither<String, List<UserReportModel>> getAllReport() => TaskEither.tryCatch(() async {
        return await GetIt.I<UserReportService>().reportAll();
      }, (error, stackTrace) => error.toString());
}
