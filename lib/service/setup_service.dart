import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/authorize_http.dart';
import 'package:hui_management/service/fund_service.dart';
import 'package:hui_management/service/image_service.dart';
import 'package:hui_management/service/login_service.dart';
import 'package:hui_management/service/notification_service.dart';
import 'package:hui_management/service/payment_service.dart';
import 'package:hui_management/service/user_service.dart';

class SetupService {
  static final getIt = GetIt.instance;

  static void setup() {
    log('registing normal services');
    getIt.registerLazySingleton(() => LoginService());
    getIt.registerLazySingleton(() => UserService());
    getIt.registerLazySingleton(() => FundService());
    getIt.registerLazySingleton(() => PaymentService());
    getIt.registerLazySingleton(() => ImageService());
    getIt.registerLazySingleton(() => NotificationService());
  }

  static void setupAuthorizeServiced(String token) {
    log('regis authorize service..');
    log(token);

    getIt.registerLazySingleton(() => AuthorizeHttp(token: token));
  }
}
