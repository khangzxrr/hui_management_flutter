import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/authorizeHttp.dart';
import 'package:hui_management/model/fund_model.dart';

class FundService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future<Fund?> update(Fund fund) async {
    try {
      final response = await httpClient.put(
        Uri.parse('http://localhost:57678/funds'),
        body: jsonEncode(fund.toJson()),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body)['fund'];

        return Fund.fromJson(json);
      }

      log(response.body);
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  Future<Fund?> create(Fund fund) async {
    try {
      final response = await httpClient.post(
        Uri.parse('http://localhost:57678/funds'),
        body: jsonEncode(fund.toJson()),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body)['fund'];

        return Fund.fromJson(json);
      }

      log(response.body);
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

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
