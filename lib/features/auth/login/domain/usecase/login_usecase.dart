import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/auth/login/domain/repository/login_repository.dart';

class LoginUsecase {
  final LoginRepository _loginRepository;
  LoginUsecase(this._loginRepository);
  ResultVoid call(String username, String password) async {
    return await _loginRepository.login(username, password);
  }
}
