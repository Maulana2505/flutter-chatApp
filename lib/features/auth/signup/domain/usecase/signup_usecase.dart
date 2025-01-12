
import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/auth/signup/domain/repository/signup_repository.dart';

class SignupUsecase {
  final SignupRepository repository;
  SignupUsecase({
    required this.repository,
  });
  ResultVoid call(String username, String password, String confirmPassword,
      String gender) async {
    return await repository.signUp(
        username,
        password,
        confirmPassword,
        gender);
  }
}
