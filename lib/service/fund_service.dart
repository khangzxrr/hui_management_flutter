import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/authorizeHttp.dart';
import 'package:hui_management/model/fund_model.dart';

class FundService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  TaskEither<String, bool> archived(Fund fund, bool isArchived) => TaskEither.tryCatch(() async {
        final response = await httpClient.get(Uri.parse('http://localhost:57678/funds/${fund.id}/archive?isArchived=$isArchived'));

        if (response.statusCode == 200) {
          return true;
        }

        throw Exception(response.body);
      }, (error, stackTrace) => error.toString());

  TaskEither<String, Fund> update(Fund fund) => TaskEither.tryCatch(() async {
        final response = await httpClient.put(
          Uri.parse('http://localhost:57678/funds'),
          body: jsonEncode(fund.toJson()),
        );

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body)['fund'];

          return Fund.fromJson(json);
        }

        throw Exception(response.body);
      }, (error, stackTrace) => error.toString());

  TaskEither<String, Fund> create(Fund fund) => TaskEither.tryCatch(() async {
        final response = await httpClient.post(
          Uri.parse('http://localhost:57678/funds'),
          body: jsonEncode(fund.toJson()),
        );

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body)['fund'];

          return Fund.fromJson(json);
        }

        throw Exception(response.body);
      }, (error, stackTrace) => error.toString());

  Future<List<Fund>?> getAll() async {
    try {
      final response = await httpClient.get(Uri.parse('http://localhost:57678/funds'));

      if (response.statusCode == 200) {
        final Iterable jsonIterable = jsonDecode(response.body)['funds'];

        return List<Fund>.from(
          jsonIterable.map((e) => Fund.fromJson(e)),
        );
      }

      log(response.body);
    } catch (e) {
      log(e.toString());
    }

    return null;
  }
}
