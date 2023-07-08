import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthorizeHttp extends http.BaseClient {
  final _http = http.Client();
  final _getIt = GetIt.instance;

  late final String token;

  AuthorizeHttp({required this.token});

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
