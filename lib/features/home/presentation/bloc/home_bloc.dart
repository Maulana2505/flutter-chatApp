import 'dart:convert';

import 'package:chatapp/core/utils/socket.dart';
import 'package:chatapp/features/home/data/model/home_model.dart';
import 'package:chatapp/features/home/domain/entity/home_entity.dart';
import 'package:chatapp/features/home/domain/usecase/home_usecase.dart';
import 'package:chatapp/features/home/presentation/bloc/home_event.dart';
import 'package:chatapp/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUsecase homeUsecase;

  final Socket _socket = Socket();
  HomeBloc(this.homeUsecase) : super(HomeInitialState()) {
    on<HomeLoadDataEvent>(_loadData);
    on<HomeRecieverEvent>(_homeReciever);
    _socketListener();
  }

  void _socketListener() {
    try {
      _socket.socket.on("newMessage", _homeUpdate);
      _socket.socket.on("newMessage2", _homeUpdate);
    } catch (e) {
      print("Erorr Socket : $e");
    }
  }

  void _loadData(HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final data = await homeUsecase.call();
    data.fold(
      (l) => emit(HomeErrorState(l.massage)),
      (r) => emit(HomeLoadDataState(r)),
    );
  }

  void _homeReciever(HomeRecieverEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoadDataState) {
      final data =
          List<HomeEntity>.from((state as HomeLoadDataState).entity.map(
                (e) => e.messages.add(event.message),
              ));
      emit(HomeLoadDataState(data));
    }
  }

  void _homeUpdate(data) {
    add(HomeLoadDataEvent());
  }
}
