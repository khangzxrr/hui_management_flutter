import 'package:hive_flutter/adapters.dart';

import '../model/authentication_model.dart';
import '../model/sub_user_model.dart';

class HiveConfiguration {
  static Future<void> setup() async {
    await Hive.initFlutter();

    Hive.registerAdapter(AuthenticationModelAdapter());
    Hive.registerAdapter(SubUserModelAdapter());

    await Hive.openBox('authentication');
  }
}
