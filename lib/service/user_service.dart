import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/authorize_http.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/model/sub_user_with_payment_report.dart';

import '../filters/subuser_filter.dart';
import '../helper/constants.dart';

class UserService {
  Future<bool> delete(int id) async {
    final httpClient = GetIt.I<AuthorizeHttp>();

    final response = await httpClient.delete(Uri.parse('${Constants.apiHostName}/subusers/$id'));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(response.body);
  }

  Future<SubUserModel?> update(SubUserModel updateUser) async {
    final httpClient = GetIt.I<AuthorizeHttp>();

    final response = await httpClient.put(Uri.parse('${Constants.apiHostName}/subusers'), body: jsonEncode(updateUser.toJson()));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['subUser'];

      return SubUserModel.fromJson(json);
    }

    throw Exception(response.body);
  }

  Future<SubUserModel> createNew(SubUserModel user) async {
    final httpClient = GetIt.I<AuthorizeHttp>();

    final response = await httpClient.post(Uri.parse('${Constants.apiHostName}/subusers'), body: jsonEncode(user.toJson()));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['subUser'];

      return SubUserModel.fromJson(json);
    }

    throw Exception(response.body);
  }

  Future<List<SubUserWithPaymentReport>> getAllWithPaymentReport(int pageIndex, int pageSize, SubUserFilter filter) async {
    final httpClient = GetIt.I<AuthorizeHttp>();

    Map<String, dynamic> queryParams = {
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString(),
    };

    queryParams.addAll(filter.toMap());

    Uri uri;

    if (Constants.apiHostName.contains("https")) {
      uri = Uri.https(Constants.apiHostName.replaceAll('https://', ''), '/subusers/reports', queryParams);
    } else {
      uri = Uri.http(Constants.apiHostName.replaceAll('http://', ''), '/subusers/reports', queryParams);
    }

    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      final Iterable jsonObj = jsonDecode(response.body)['subUserReportRecords'];

      return List<SubUserWithPaymentReport>.from(jsonObj.map((model) => SubUserWithPaymentReport.fromJson(model)));
    }

    throw Exception(response.body);
  }

  Future<List<SubUserModel>> getAll(int pageIndex, int pageSize, SubUserFilter filter) async {
    final httpClient = GetIt.I<AuthorizeHttp>();

    Map<String, dynamic> queryParams = {
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString(),
    };

    queryParams.addAll(filter.toMap());

    final uri = httpClient.generateUriWithParams('/subusers', queryParams);

    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      final Iterable jsonObj = jsonDecode(response.body)['subUsers'];

      return List<SubUserModel>.from(jsonObj.map((model) => SubUserModel.fromJson(model)));
    }

    throw Exception(response.body);
  }

  Future<SubUserWithPaymentReport> getByIdWithReport(int subuserId) async {
    final httpClient = GetIt.I<AuthorizeHttp>();

    final uri = httpClient.generateUriWithParams('/subusers/$subuserId/reports', {});

    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      final jsonObj = jsonDecode(response.body)['subUserReportRecord'];

      return SubUserWithPaymentReport.fromJson(jsonObj);
    }

    throw Exception(response.body);
  }
}
