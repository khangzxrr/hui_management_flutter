import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthorizeHttp extends http.BaseClient {
  final _http = http.Client();

  late final String token;

  AuthorizeHttp({required this.token});

  Future<dynamic> getJson(String url) async {
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(response.body);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    var defaultHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    request.headers.addAll(defaultHeaders);

    return _http.send(request);
  }
}
