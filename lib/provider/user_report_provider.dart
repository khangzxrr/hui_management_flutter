import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

import '../model/user_report_model.dart';
import '../service/user_report_service.dart';

class UserReportProvider with ChangeNotifier {
  bool loading = false;
  List<UserReportModel> userReportModels = [];

  TaskEither<String, void> getAllReport() => TaskEither.tryCatch(() async {
        loading = true;
        notifyListeners();

        userReportModels = await GetIt.I<UserReportService>().reportAll();

        print(userReportModels.length);

        loading = false;
        notifyListeners();
      }, (error, stackTrace) => error.toString());
}
