import 'dart:convert';
import 'dart:io';
import 'package:chatapp/core/utils/constant.dart';
import 'package:chatapp/core/utils/storage.dart';
import 'package:chatapp/features/chat/data/model/chat_model.dart';
import 'package:http/http.dart' as http;

abstract class ChatRemoteDatasource {
  Future<List<ChatModel>> getChat(String id);
  Future<void> sendChat(String receiverId, String message);
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final http.Client client;
  ChatRemoteDatasourceImpl(this.client);
  @override
  Future<List<ChatModel>> getChat(String id) async {
    var url = Constant.url;
    var token = await Storage().read("token");
    final res = await http.get(Uri.parse("$url/messages/$id"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    if (res.statusCode == 200) {
      List<ChatModel> data = (json.decode(res.body) as List)
          .map((x) => ChatModel.fromJson(x))
          .toList();
      print(data.toString());
      return data;
    } else {
      throw Exception(res.body);
    }
  }

  @override
  Future<void> sendChat(String receiverId, String message) async {
    var url = Constant.url;
    var token = await Storage().read("token");
    var id = await Storage().read("id");
    final response = await client.post(
      Uri.parse("$url/messages/send/$receiverId"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      body: {'senderId': id, 'receiverId': receiverId, 'message': message},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } 
  }
}
