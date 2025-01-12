import 'package:chatapp/core/utils/socket.dart';
import 'package:chatapp/features/chat/data/model/chat_model.dart';
import 'package:chatapp/features/chat/domain/entity/chat_entity.dart';
import 'package:chatapp/features/chat/domain/usecase/chat_usecase.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_event.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/core/utils/storage.dart';

class GetchatBloc extends Bloc<GetchatEvent, GetchatState> {
  final GetChatUsecase getChatUsecase;
  final SendChatUsecase sendChatUsecase;
  final Socket _socket = Socket();
  final List<ChatEntity> _chat = [];
  GetchatBloc(this.getChatUsecase, this.sendChatUsecase)
      : super(GetchatInitialState()) {
    on<GetchatLoadEvent>(_loadData);
    on<SendMassageEvent>(_sendMassage);
    on<MassageRecieverEvent>(_massageRiciever);
  }
  void _loadData(GetchatLoadEvent event, Emitter<GetchatState> emit) async {
    emit(GetchatLoadingState());
    final data = await getChatUsecase.call(event.id);
    data.fold(
      (l) => emit(GetchatErrorState(l.massage)),
      (r) {
        _chat.clear();
        _chat.addAll(r);
        emit(GetchatLoadState(r));
        _socket.socket.on(
          "newMessage",
          (data) {
            print("ini socktet newMassage : $data");

            add(MassageRecieverEvent(ChatModel.fromJson(data)));
          },
        );
      },
    );
  }

  void _sendMassage(SendMassageEvent event, Emitter<GetchatState> emit) async {
    var token = await Storage().read("id");
    final data = await sendChatUsecase(event.recieverId, event.message);
    data.fold(
      (l) => emit(SendMassageError(l.massage)),
      (r) {
        final newmassage = ChatEntity(
            id: "",
            senderId: token,
            receiverId: event.recieverId,
            message: event.message,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now());
        final data = List<ChatEntity>.from((state as GetchatLoadState).chat)
          ..add(newmassage);
        emit(GetchatLoadState(data));
        // _socket.socket.emit("newMessage", data);
      },
    );

    @override
    Future<void> close() {
      return super.close();
    }
  }

  void _massageRiciever(
      MassageRecieverEvent event, Emitter<GetchatState> emit) {
    if (state is GetchatLoadState) {
      // final data = List<ChatEntity>.from((state as GetchatLoadState).chat)
      //   ..add(event.message);
      final massage = ChatEntity(
            id: event.message.id,
            senderId: event.message.senderId,
            receiverId: event.message.receiverId,
            message: event.message.message,
            createdAt: event.message.createdAt,
            updatedAt: event.message.updatedAt);
        _chat.add(massage);
      emit(GetchatLoadState(List.from(_chat)));
    }
  }
}
