import 'package:get_it/get_it.dart';
import 'package:hui_management/service/login_service.dart';

class SetupService {
  final getIt = GetIt.instance;

  void setup() {
    getIt.registerFactory(() => LoginService());
  }
}
