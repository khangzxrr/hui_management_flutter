import 'dart:convert';
import 'package:http/http.dart' as http;

import 'constants.dart';

class AuthorizeHttp extends http.BaseClient {
  final _http = http.Client();

  late final String token;

  AuthorizeHttp({required this.token});

  Uri generateUriWithParams(String path, Map<String, dynamic> params) {
    Uri uri;

    if (Constants.apiHostName.contains("https")) {
      uri = Uri.https(Constants.apiHostName.replaceAll('https://', ''), path, params);
    } else {
      uri = Uri.http(Constants.apiHostName.replaceAll('http://', ''), path, params);
    }

    return uri;
  }

  Future<dynamic> postJson(String url, dynamic body) async {
    final response = await post(Uri.parse(url), body: jsonEncode(body));

    if (response.statusCode == 200) {
      return response.body;
    }

    throw Exception(response.body);
  }

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
