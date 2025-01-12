import 'package:chatapp/core/utils/storage.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_bloc.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_event.dart';
import 'package:chatapp/features/chat/presentation/page/chat_page.dart';
import 'package:chatapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:chatapp/features/home/presentation/bloc/home_event.dart';
import 'package:chatapp/features/search/presentation/bloc/search_bloc.dart';
import 'package:chatapp/features/search/presentation/bloc/search_event.dart';
import 'package:chatapp/features/search/presentation/bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _find = TextEditingController()..text;
  String ids = "";
  String q = "";
  @override
  void initState() {
    
    super.initState();
    _getid();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _find.dispose();
  }

  _getid() async {
    final data = await Storage().read("id");
    return ids = data;
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
        _find.clear();
        Navigator.pop(context);
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [_search(), Expanded(child: _result())],
        )),
      ),
    );
  }

  Widget _search() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              _find.clear();
              q = "";
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              autofocus: true,
              controller: _find,
              onChanged: (value) {
                q = value;
                BlocProvider.of<SearchBloc>(context).add(SearchLoadEvent(q));
                // print(data);
              },
              style: const TextStyle(color: Colors.black, fontSize: 17),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: "Search",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                suffixIcon: _find.text.isEmpty
                    ? Container(
                        width: 0,
                      )
                    : IconButton(
                        onPressed: () {
                          _find.clear();
                          q = "";
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ))
      ],
    );
  }

  Widget _result() {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchLoadingState) {
          BlocProvider.of<SearchBloc>(context).add(SearchLoadEvent(q));
        }
      },
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchLoadState) {
            return ListView.builder(
              itemCount: state.search.length,
              itemBuilder: (context, index) {
                var data = state.search[index];
                return InkWell(
                  onTap: () {
                    context.read<GetchatBloc>().add(GetchatLoadEvent(data.id));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            id: data.id,
                            datasearch: data,
                            ids : ids
                          ),
                        ));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                        maxRadius: 20,
                        backgroundImage: NetworkImage(data.profilepic)),
                    title: Text(data.username),
                  ),
                );
              },
            );
          }
          if (state is SearchErrorState) {
            return Center(
              child: Text("state.msg"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
