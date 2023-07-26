import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/authorizeHttp.dart';
import 'package:hui_management/service/fund_service.dart';
import 'package:hui_management/service/image_service.dart';
import 'package:hui_management/service/login_service.dart';
import 'package:hui_management/service/payment_service.dart';
import 'package:hui_management/service/user_service.dart';

class SetupService {
  static final getIt = GetIt.instance;

  static void setup() {
    getIt.registerFactory(() => LoginService());
    getIt.registerFactory(() => UserService());
    getIt.registerFactory(() => FundService());
    getIt.registerFactory(() => PaymentService());
    getIt.registerFactory(() => ImageService());
  }

  static void setupAuthorizeServiced(String token) {
    if (getIt.isRegistered<AuthorizeHttp>()) {
      getIt.unregister<AuthorizeHttp>();
    }
    log('regis authorize service..');
    log(token);

    getIt.registerFactory(() => AuthorizeHttp(token: token));
  }
}
