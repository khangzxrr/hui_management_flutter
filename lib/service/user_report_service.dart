import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:hui_management/model/user_report_model.dart';

import '../helper/authorize_http.dart';
import '../helper/constants.dart';

class UserReportService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future<List<UserReportModel>> reportAll() async {
    final response = await httpClient.get(Uri.parse('${Constants.apiHostName}/users/report?getFundRatio=true&getTotalCostRemain=true'));

    if (response.statusCode == 200) {
      final Iterable jsonObj = jsonDecode(response.body)['subUsers'];

      return List<UserReportModel>.from(jsonObj.map((model) => UserReportModel.fromJson(model)));
    }

    throw Exception(response.body);
  }
}
