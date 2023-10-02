import 'package:get_it/get_it.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../helper/authorize_http.dart';
import '../helper/constants.dart';

class NotificationService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future<void> storeNewFcmToken(String fcmToken) async {
    await httpClient.postJson('${Constants.apiHostName}/users/notificationtokens', {
      'Token': fcmToken,
    });
  }

  // Future<String?> requestPermission() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     // print('Got a message whilst in the foreground!');
  //     // print('Message data: ${message.data}');

  //     // if (message.notification != null) {
  //     //   print('Message also contained a notification: ${message.notification!.body}');
  //     // }
  //   });
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   String? previousFcmToken = prefs.getString(Constants.fcmTokenPref);

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     final fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: Constants.webPushNotificationToken);

  //     print('FCM token: $fcmToken');

  //     if (fcmToken == null) {
  //       return null;
  //     }

  //     if (previousFcmToken != null && previousFcmToken == fcmToken) {
  //       return fcmToken;
  //     }

  //     await prefs.setString(Constants.fcmTokenPref, fcmToken);
  //     await storeNewFcmToken(fcmToken);
  //   }

  //   return null;
  // }
}
