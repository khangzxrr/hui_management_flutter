import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/authorizeHttp.dart';
import 'package:hui_management/model/user_model.dart';

import '../helper/constants.dart';

class UserService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future<bool> delete(int id) async {
    final response = await httpClient.delete(Uri.parse('${Constants.apiHostName}/users/$id'));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(response.body);
  }

  Future<UserModel?> update(UserModel updateUser) async {
    final response = await httpClient.put(Uri.parse('${Constants.apiHostName}/users'), body: jsonEncode(updateUser.toJson()));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['user'];

      return UserModel.fromJson(json);
    }

    throw Exception(response.body);
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
    final response = await httpClient.post(Uri.parse('${Constants.apiHostName}/users'),
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
    }

    throw Exception(response.body);
  }

  Future<List<UserModel>> getAll() async {
    final response = await httpClient.get(Uri.parse('${Constants.apiHostName}/users'));

    if (response.statusCode == 200) {
      final Iterable jsonObj = jsonDecode(response.body)['users'];

      return List<UserModel>.from(jsonObj.map((model) => UserModel.fromJson(model)));
    }

    throw Exception(response.body);
  }
}
