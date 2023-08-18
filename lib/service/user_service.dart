import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/authorize_http.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/model/user_with_payment_report.dart';

import '../helper/constants.dart';

class UserService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future<bool> delete(int id) async {
    final response = await httpClient.delete(Uri.parse('${Constants.apiHostName}/subusers/$id'));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(response.body);
  }

  Future<SubUserModel?> update(SubUserModel updateUser) async {
    final response = await httpClient.put(Uri.parse('${Constants.apiHostName}/subusers'), body: jsonEncode(updateUser.toJson()));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['subUser'];

      return SubUserModel.fromJson(json);
    }

    throw Exception(response.body);
  }

  Future<SubUserModel> createNew(SubUserModel user) async {
    final response = await httpClient.post(Uri.parse('${Constants.apiHostName}/subusers'), body: jsonEncode(user.toJson()));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['subUser'];

      return SubUserModel.fromJson(json);
    }

    throw Exception(response.body);
  }

  Future<List<UserWithPaymentReport>> getAllWithPaymentReport() async {
    Map<String, String> queryParams = {};
    queryParams['filterByAnyPayment'] = 'true';

    Uri uri;

    if (Constants.apiHostName.contains("https")) {
      uri = Uri.https(Constants.apiHostName.replaceAll('https://', ''), '/subusers', queryParams);
    } else {
      uri = Uri.http(Constants.apiHostName.replaceAll('http://', ''), '/subusers', queryParams);
    }

    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      final Iterable jsonObj = jsonDecode(response.body)['subUsers'];

      return List<UserWithPaymentReport>.from(jsonObj.map((model) => UserWithPaymentReport.fromJson(model)));
    }

    throw Exception(response.body);
  }

  Future<List<SubUserModel>> getAll({
    bool filterByAnyPayment = false,
    bool filterByNotFinishedPayment = false,
    bool getFundRatio = false,
  }) async {
    Map<String, String> queryParams = {};

    if (filterByAnyPayment) {
      queryParams['filterByAnyPayment'] = 'true';
    }
    if (filterByNotFinishedPayment) {
      queryParams['filterByNotFinishedPayment'] = 'true';
    }
    if (getFundRatio) {
      queryParams['getFundRatio'] = 'true';
    }

    Uri uri;

    if (Constants.apiHostName.contains("https")) {
      uri = Uri.https(Constants.apiHostName.replaceAll('https://', ''), '/subusers', queryParams);
    } else {
      uri = Uri.http(Constants.apiHostName.replaceAll('http://', ''), '/subusers', queryParams);
    }

    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      final Iterable jsonObj = jsonDecode(response.body)['subUsers'];

      return List<SubUserModel>.from(jsonObj.map((model) => SubUserModel.fromJson(model)));
    }

    throw Exception(response.body);
  }
}
