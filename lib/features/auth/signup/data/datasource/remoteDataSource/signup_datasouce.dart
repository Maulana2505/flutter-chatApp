import 'dart:convert';
import 'package:chatapp/core/utils/constant.dart';
import 'package:http/http.dart' as http;

abstract class SignupDatasouce {
  Future<void> signup(
      String username, String password, String confirmPassword, String gender);
}

class SignupDatasouceImpl implements SignupDatasouce {
  final http.Client client;
  SignupDatasouceImpl({
    required this.client,
  });
  var url = Constant.url;
  @override
  Future<void> signup(String username, String password, String confirmPassword,
      String gender) async {
    final response = await client.post(Uri.parse("$url/signup"), body: {
      'username': username,
      'password': password,
      'confirmpassword': confirmPassword,
      'gender': gender
    });
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body));
      throw Exception(json.decode(response.body)['msg']);
    }
  }
}
