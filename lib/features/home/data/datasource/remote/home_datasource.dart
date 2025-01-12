import 'dart:convert';
import 'dart:io';

import 'package:chatapp/core/utils/storage.dart';
import 'package:http/http.dart' as http;

import 'package:chatapp/core/utils/constant.dart';
import 'package:chatapp/features/home/data/model/home_model.dart';

abstract class HomeRemoteDatasource {
  Future<List<HomeModel>> get();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final http.Client client;
  HomeRemoteDatasourceImpl(
    this.client,
  );
  @override
  Future<List<HomeModel>> get() async {
    var url = Constant.url;
    var token = await Storage().read("token");
    var id = await Storage().read("id");

    // var token = await SharedPreference().getToken();
    // var id = await SharedPreference().getid();

    print(id);
    print(token);
    final res = await http.get(Uri.parse("$url/messages"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    if (res.statusCode == 200) {
      List<HomeModel> data = (json.decode(res.body) as List)
          .map((x) => HomeModel.fromJson(x))
          .toList();
      print(data.toString());
      return data;
    } else {
      throw Exception(res.body);
    }
  }
}
