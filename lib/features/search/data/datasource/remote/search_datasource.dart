import 'dart:convert';
import 'dart:io';
import 'package:chatapp/features/search/data/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/core/utils/storage.dart';
import 'package:chatapp/core/utils/constant.dart';

abstract class SearchDatasource {
  Future<List<SearchModel>> get(String query);
}

class SearchDatasourceImpl implements SearchDatasource {
  final http.Client client;
  SearchDatasourceImpl(this.client);
  @override
  Future<List<SearchModel>> get(String query) async {
    var url = Constant.url;
    var token = await Storage().read("token");
    // var id = await Storage().read("id");
    final res = await client.get(Uri.parse("$url/user/$query"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    if (res.statusCode == 200) {
      List<SearchModel> data = (json.decode(res.body) as List)
          .map((x) => SearchModel.fromJson(x))
          .toList();
      return data;
    } else {
      throw Exception(res.body);
    }
  }
}
