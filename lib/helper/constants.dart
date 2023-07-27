import 'package:flutter/widgets.dart';

class Constants {
  static const String apiHostName = "https://hui-management-app-2023.gentleground-a6c01d82.australiaeast.azurecontainerapps.io";
  static const String domain = "hui-management-app-2023.gentleground-a6c01d82.australiaeast.azurecontainerapps.io";
  // static const String apiHostName = "http://localhost:57679";
  // static const String domain = "localhost:57679";

  //load member.jpg into a image from assets
  static const Image defaultAvatar = Image(
    image: AssetImage('assets/images/member.jpg'),
    fit: BoxFit.cover,
  );

  static const defaultAvatarPath = 'user.jpg';
  static const randomAvatarPath = 'https://picsum.photos/200';
}
