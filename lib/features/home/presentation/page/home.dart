import 'package:chatapp/core/utils/screensize.dart';
import 'package:chatapp/core/utils/socket.dart';
import 'package:chatapp/core/utils/storage.dart';
import 'package:chatapp/features/auth/bloc/auth_bloc.dart';
import 'package:chatapp/features/auth/bloc/auth_event.dart';
import 'package:chatapp/features/auth/bloc/auth_state.dart';
import 'package:chatapp/features/auth/login/presentation/page/login.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_bloc.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_event.dart';
import 'package:chatapp/features/chat/presentation/page/chat_page.dart';
import 'package:chatapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:chatapp/features/home/presentation/bloc/home_state.dart';
import 'package:chatapp/features/search/presentation/bloc/search_bloc.dart';
import 'package:chatapp/features/search/presentation/bloc/search_event.dart';
import 'package:chatapp/features/search/presentation/page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _getid();
    // setState(() {
    //   _socket();
    // });
  }

  _socket() async {
    Socket().connecttoSocket();
  }

  String ids = "";
  _getid() async {
    final data = await Storage().read("id");
    return ids = data;
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LogOutSuccesState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<SearchBloc>(context).add(SearchLoadEvent(""));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchPage()));
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      context.read<AuthenticationBloc>().add(LogOut());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    icon: const Icon(Icons.exit_to_app)),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(
                        child: Text("Loading..."),
                      );
                    }
                    if (state is HomeErrorState) {
                      return Center(
                        child: Text(state.msg),
                      );
                    }
                    if (state is HomeLoadDataState) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.entity.length,
                        itemBuilder: (context, index) {
                          var data = state.entity[index];
                          return Column(
                            children: [
                              for (var e in data.participants)
                                ids != e.id
                                    ? InkWell(
                                        onTap: () {
                                          context
                                              .read<GetchatBloc>()
                                              .add(GetchatLoadEvent(e.id));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChatPage(
                                                  data: data,
                                                  id: e.id,
                                                  ids: ids,
                                                ),
                                              ));
                                        },
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 28,
                                              // backgroundColor:
                                              //     users.join(",").contains(e.id)
                                              //         ? Colors.green
                                              //         : Colors.black,
                                              child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      e.profilepic)),
                                            ),
                                            SizedBox(
                                              width:
                                                  displayWidth(context) * 0.02,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(e.username),
                                                Text(data.messages.last.message)
                                              ],
                                            ),
                                            // print()
                                          ],
                                        ),
                                      )
                                    : Container(),
                            ],
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
