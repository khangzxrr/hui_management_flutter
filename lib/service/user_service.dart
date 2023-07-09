import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/authorizeHttp.dart';
import 'package:hui_management/model/user_model.dart';

class UserService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future<bool> delete(int id) async {
    try {
      final response = await httpClient.delete(Uri.parse('http://localhost:57678/users/$id'));

      if (response.statusCode == 200) {
        return true;
      } else {
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
    }

    return false;
  }

  Future<UserModel?> update({
    required int id,
    required String name,
    required String password,
    required String email,
    required String phonenumber,
    required String bankname,
    required String banknumber,
    required String address,
    required String additionalInfo,
  }) async {
    try {
      final response = await httpClient.put(Uri.parse('http://localhost:57678/users'),
          body: jsonEncode({
            "id": id,
            "name": name,
            "password": password,
            "email": email,
            "phonenumber": phonenumber,
            "bankname": bankname,
            "banknumber": banknumber,
            "address": address,
            "additionalInfo": additionalInfo,
          }));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body)['user'];

        return UserModel.fromJson(json);
      } else {
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  Future<UserModel?> createNew({
    required String name,
    required String password,
    required String email,
    required String phonenumber,
    required String bankname,
    required String banknumber,
    required String address,
    required String additionalInfo,
  }) async {
    try {
      final response = await httpClient.post(Uri.parse('http://localhost:57678/users'),
          body: jsonEncode({
            "name": name,
            "password": password,
            "email": email,
            "phonenumber": phonenumber,
            "bankname": bankname,
            "banknumber": banknumber,
            "address": address,
            "additionalInfo": additionalInfo,
          }));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body)['user'];

        return UserModel.fromJson(json);
      } else {
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  Future<List<UserModel>?> getAll() async {
    try {
      final response = await httpClient.get(Uri.parse('http://localhost:57678/users'));

      if (response.statusCode == 200) {
        final Iterable jsonObj = jsonDecode(response.body)['users'];

        return List<UserModel>.from(jsonObj.map((model) => UserModel.fromJson(model)));
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }
}
