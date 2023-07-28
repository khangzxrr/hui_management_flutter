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

  Future<UserModel> createNew(UserModel user) async {
    final response = await httpClient.post(Uri.parse('${Constants.apiHostName}/users'), body: jsonEncode(user.toJson()));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['user'];

      return UserModel.fromJson(json);
    }

    throw Exception(response.body);
  }

  Future<List<UserModel>> getAll({
    bool filterByAnyPayment = false,
    bool filterByNotFinishedPayment = false,
  }) async {
    Map<String, String> queryParams = {};

    if (filterByAnyPayment) {
      queryParams['filterByAnyPayment'] = 'true';
    }
    if (filterByNotFinishedPayment) {
      queryParams['filterByNotFinishedPayment'] = 'true';
    }

    Uri uri;

    if (Constants.apiHostName.contains("https")) {
      uri = Uri.https(Constants.apiHostName.replaceAll('https://', ''), '/users', queryParams);
    } else {
      uri = Uri.http(Constants.apiHostName.replaceAll('http://', ''), '/users', queryParams);
    }

    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      final Iterable jsonObj = jsonDecode(response.body)['users'];

      return List<UserModel>.from(jsonObj.map((model) => UserModel.fromJson(model)));
    }

    throw Exception(response.body);
  }
}
