import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:hui_management/model/authentication_model.dart';

class LoginService {
  Future<AuthenticationModel?> login(String phonenumber, String password) async {
    try {
      final body = jsonEncode({
        "phonenumber": phonenumber,
        "password": password,
      });

      final response = await http.post(
        Uri.parse('http://localhost:57678/login'),
        body: body,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return AuthenticationModel.fromJson(data);
      } else {
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }
}
