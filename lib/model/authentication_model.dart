class AuthenticationModel {
  final String token;
  final String name;
  final String phonenumber;
  final String email;

  AuthenticationModel({required this.token, required this.name, required this.phonenumber, required this.email});

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(token: json['token'], name: json['name'], phonenumber: json['phonenumber'], email: json['email']);
  }

  @override
  String toString() {
    return '{${email} ${name} ${phonenumber} ${token}}';
  }
}
