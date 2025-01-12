import 'package:chatapp/features/auth/signup/domain/usecase/signup_usecase.dart';
import 'package:chatapp/features/auth/signup/presentation/bloc/signup_event.dart';
import 'package:chatapp/features/auth/signup/presentation/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUsecase signupUsecase;
  SignupBloc(this.signupUsecase) : super(SignnupInitialState()) {
    on<SignupDataEvent>(_dataEvent);
  }
  void _dataEvent(SignupDataEvent event, Emitter<SignupState> emit) async {
    emit(SignupLoadingState());
    final signup = await signupUsecase.call(
        event.username, event.password, event.confirmPassword, event.gender);
    signup.fold(
      (l) => emit(SignupErrorState(l.massage)),
      (r) => emit(SignupSuccesState()),
    );
  }
}
