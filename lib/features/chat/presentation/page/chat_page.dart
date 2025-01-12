import 'package:chatapp/core/utils/screensize.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_bloc.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_event.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_state.dart';
import 'package:chatapp/features/chat/presentation/widget/costumCardChat.dart';
import 'package:chatapp/features/home/domain/entity/home_entity.dart';
import 'package:chatapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:chatapp/features/home/presentation/bloc/home_event.dart';
import 'package:chatapp/features/search/domain/entity/search_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatPage extends StatefulWidget {
  final HomeEntity? data;
  final SearchEntity? datasearch;
  final String? id;
  final String? ids;
  const ChatPage({super.key, this.data, this.id, this.datasearch, this.ids});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _massage = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  io.Socket? socket;

  @override
  void initState() {
    super.initState();
    print(widget.id);
    // _scroll();
  }

  @override
  void dispose() {
    super.dispose();
    _massage.dispose();
    _scrollController.dispose();
  }

  void _scroll() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        context.read<HomeBloc>().add(HomeLoadDataEvent());
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: _appbar(),
        body: _listchat(),
      ),
    );
  }

  _appbar() {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          if (widget.data == null)
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.datasearch!.profilepic),
                ),
                Text(widget.datasearch!.username)
              ],
            ),
          if (widget.datasearch == null)
            for (var e in widget.data!.participants)
              e.id != widget.ids
                  ? Column(
                      children: [
                        CircleAvatar(
                            backgroundImage: NetworkImage(e.profilepic)),
                        Text(e.username)
                      ],
                    )
                  : Container()
        ],
      ),
    );
  }

  _listchat() {
    return Column(
      children: [
        Expanded(child: BlocBuilder<GetchatBloc, GetchatState>(
          builder: (context, state) {
            if (state is GetchatLoadState) {
              var v = state.chat
                ..sort(
                  (a, b) => b.createdAt.compareTo(a.createdAt),
                );
              return ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: v.length,
                reverse: true,
                itemBuilder: (context, index) {
                  var y = v[index];
                  return Column(
                    children: [
                      y.senderId.contains(widget.ids!)
                          ? CostumcardChat(msg: y.message, me: true)
                          : CostumcardChat(msg: y.message, me: false)
                    ],
                  );
                },
              );
            }
            if (state is GetchatErrorState) {
              return Center(
                child: Text(state.msg),
              );
            }
            return Container();
          },
        )),
        _sendField()
      ],
    );
  }

  _sendField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: displayWidth(context) * 0.8,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                          controller: _massage,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: "Type",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.black,
                        child: IconButton(
                          icon: Icon(Icons.send),
                          color: Colors.white,
                          onPressed: () {
                            var data = 
                            context.read<GetchatBloc>()
                              ..add(
                                  SendMassageEvent(widget.id!, _massage.text));
                            socket?.emit("newMessage", data);
                            _massage.clear();
                          },
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
