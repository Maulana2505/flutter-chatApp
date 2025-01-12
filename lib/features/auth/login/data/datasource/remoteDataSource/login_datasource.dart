import 'dart:convert';
import 'package:chatapp/core/utils/constant.dart';

import 'package:chatapp/core/utils/storage.dart';
import 'package:http/http.dart' as http;

abstract class LoginDatasource {
  Future<void> login(String username, String password);
}

class LoginDatasourceImpl implements LoginDatasource {
  final http.Client client;
  LoginDatasourceImpl(this.client);
  var url = Constant.url;

  @override
  Future<void> login(String username, String password) async {
    final response = await client.post(Uri.parse("$url/login"),
     body: {
      'username': username,
      'password': password,
    }, 
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      Storage().writeToken("token",json.decode(response.body)["token"]);
      Storage().writeToken("id",json.decode(response.body)["data"]["_id"]);
      // SharedPreference().setToken(json.decode(response.body)["token"]);
      // SharedPreference().setid(json.decode(response.body)["id"]);
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body)['msg']);
    }
  }
}
