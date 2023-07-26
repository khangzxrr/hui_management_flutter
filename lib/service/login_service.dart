import 'dart:convert';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/model/authentication_model.dart';

class LoginService {
  TaskEither<String, AuthenticationModel> login(String phonenumber, String password) => TaskEither.tryCatch(() async {
        final body = jsonEncode({
          "phonenumber": phonenumber,
          "password": password,
        });

        final response = await http.post(
          Uri.parse('${Constants.apiHostName}/login'),
          body: body,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return AuthenticationModel.fromJson(data);
        }

        throw Exception(response.body);
      }, (error, stackTrace) => error.toString());

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);

  //     return AuthenticationModel.fromJson(data);
  //   } else {
  //     log(response.body);
  //   }
  // } catch (e) {
  //   log(e.toString());
  // }
}
