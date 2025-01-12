

import 'package:chatapp/core/utils/typedef.dart';

abstract class LoginRepository {
  ResultVoid login(String username,String password);
}