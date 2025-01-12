import 'package:chatapp/core/utils/storage.dart';
import 'package:chatapp/features/auth/bloc/auth_event.dart';
import 'package:chatapp/features/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized()) {
    on<AppStarted>((event, emit) async {
      emit(AuthenticationLoading());
      await Storage().containsData("token")
          // await SharedPreference().constantKey("token")
          ? emit(AuthenticationAuthenticated())
          : emit(AuthenticationUnauthenticated());
    });

    on<LogOut>((event, emit) async {
      emit(LogOutLoadingState());
      await Storage().delete();
      emit(AuthenticationUnauthenticated());
    });
  }
}
