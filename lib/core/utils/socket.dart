import 'dart:async';

import 'package:chatapp/core/utils/storage.dart';
import 'package:chatapp/features/chat/data/model/chat_model.dart';

import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_bloc.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_event.dart';
import 'package:chatapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:chatapp/features/home/presentation/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socket {
  static final Socket _instance = Socket._interval();
  factory Socket() => _instance;
  Socket._interval(){
    connecttoSocket();
  }
  List _onlineUserss = [];
  List get os => _onlineUserss;
  late IO.Socket _socket;
  Future<void> connecttoSocket() async {
    var id = await Storage().read("id");
    _socket = IO.io(
        "http://192.168.100.129:4000",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({"userId": id})
            .disableAutoConnect()
            .build());
    _socket.connect();

    // _socket.onDisconnect((data) {

    // },);
    
  }
  IO.Socket get socket => _socket;

  
  // void secketConnect(BuildContext context, List users ) async {
  //   var id = await Storage().read("id");
  //   final socket = connecttoSocket(id);
  //   socket.on(
  //     'getOnlineUsers',
  //     (data) {
  //       users = List.from(data);
  //       print("dari socket repo : $users");
  //     },
  //   );
  //   socket.on(
  //     "newMessage",
  //     (data) {
  //       print("ini socktet : $data");
  //       BlocProvider.of<GetchatBloc>(context)
  //           .add(MassageRecieverEvent(ChatModel.fromJson(data)));
  //       BlocProvider.of<HomeBloc>(context).add(HomeLoadDataEvent());
  //       print("ini socktet : $data");
  //     },
  //   );
  //   socket.on(
  //     "disconnect",
  //     (data) {
  //       print("remove $data");
  //       users.remove(data.toString().split("["));
  //     },
  //   );
  //   socket.onConnectError(
  //     (data) => print(data),
  //   );
  //   socket.onError(
  //     (data) => print(data),
  //   );
  // }
}
