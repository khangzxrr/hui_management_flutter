import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/authorizeHttp.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/model/fund_model.dart';
import 'package:hui_management/model/fund_report_model.dart';
import 'package:hui_management/model/general_fund_model.dart';

class FundService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future<bool> remove(int fundId) async {
    final response = await httpClient.delete(Uri.parse('${Constants.apiHostName}/funds/$fundId'));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(response.body);
  }

  Future<bool> removeSession(int fundId, int sessionId) async {
    final response = await httpClient.delete(Uri.parse('${Constants.apiHostName}/funds/$fundId/sessions/$sessionId'));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(response.body);
  }

  Future<bool> addSession(int fundId, int memberId, double predictPrice) async {
    final response = await httpClient.post(
      Uri.parse('${Constants.apiHostName}/funds/$fundId/sessions/add'),
      body: jsonEncode({"memberId": memberId, "predictPrice": predictPrice}),
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(response.body);
  }

  Future<bool> removeMember(int fundId, int memberId) async {
    final response = await httpClient.get(Uri.parse('${Constants.apiHostName}/funds/$fundId/members/$memberId/remove'));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(response.body);
  }

  Future<bool> addMember(int fundId, int memberId) async {
    final response = await httpClient.get(Uri.parse('${Constants.apiHostName}/funds/$fundId/members/$memberId/add'));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(response.body);
  }

  Future<Fund> get(int fundId) async {
    final response = await httpClient.get(Uri.parse('${Constants.apiHostName}/funds/$fundId'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['fund'];
      log(response.body);
      return Fund.fromJson(jsonData);
    }

    throw Exception(response.body);
  }

  TaskEither<String, bool> archived(int fundId, bool isArchived) => TaskEither.tryCatch(() async {
        final response = await httpClient.get(Uri.parse('${Constants.apiHostName}/funds/$fundId/archive?isArchived=$isArchived'));

        if (response.statusCode == 200) {
          return true;
        }

        throw Exception(response.body);
      }, (error, stackTrace) => error.toString());

  TaskEither<String, GeneralFundModel> update(GeneralFundModel fund) => TaskEither.tryCatch(() async {
        final response = await httpClient.put(
          Uri.parse('${Constants.apiHostName}/funds'),
          body: jsonEncode(fund.toJson()),
        );

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body)['fund'];

          return GeneralFundModel.fromJson(json);
        }

        throw Exception(response.body);
      }, (error, stackTrace) => error.toString());

  TaskEither<String, GeneralFundModel> create(GeneralFundModel fund) => TaskEither.tryCatch(() async {
        final response = await httpClient.post(
          Uri.parse('${Constants.apiHostName}/funds'),
          body: jsonEncode(fund.toJson()),
        );

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body)['fund'];

          return GeneralFundModel.fromJson(json);
        }

        throw Exception(response.body);
      }, (error, stackTrace) => error.toString());

  Future<FundReportModel> getReport(String reportCode) async {
    final response = await httpClient.get(Uri.parse('${Constants.apiHostName}/funds/reports/$reportCode'));

    if (response.statusCode == 200) {
      return FundReportModel.fromJson(jsonDecode(response.body));
    }

    throw Exception(response.body);
  }

  Future<List<GeneralFundModel>> getAll() async {
    final response = await httpClient.get(Uri.parse('${Constants.apiHostName}/funds'));

    if (response.statusCode == 200) {
      final Iterable jsonIterable = jsonDecode(response.body)['funds'];

      return List<GeneralFundModel>.from(
        jsonIterable.map((e) {
          return GeneralFundModel.fromJson(e);
        }),
      );
    }

    throw Exception(response.body);
  }
}
