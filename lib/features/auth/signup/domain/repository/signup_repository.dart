import 'package:chatapp/core/utils/typedef.dart';

abstract class SignupRepository {
  ResultVoid signUp(
       String username,
       String password,
       String confirmPassword,
       String gender);
}
