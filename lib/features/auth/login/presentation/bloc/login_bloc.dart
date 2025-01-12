import 'package:chatapp/features/auth/login/domain/usecase/login_usecase.dart';
import 'package:chatapp/features/auth/login/presentation/bloc/login_event.dart';
import 'package:chatapp/features/auth/login/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  LoginBloc(this.loginUsecase) : super(LoginInitialState()) {
    on<LoginSuccesEvent>(_login);
  }

  void _login(LoginSuccesEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final login = await loginUsecase.call(event.username, event.password);
    login.fold(
      (l) => emit(LoginErrorState(l.massage.toString())),
      (r) => emit(LoginSuccesState()),
    );
  }
}
