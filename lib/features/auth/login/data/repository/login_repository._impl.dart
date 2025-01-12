import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/auth/login/data/datasource/remoteDataSource/login_datasource.dart';
import 'package:chatapp/features/auth/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDatasource _loginDatasource;
  LoginRepositoryImpl(this._loginDatasource);

  @override
  ResultVoid login(String username, String password) async {
    try {
      final login = await _loginDatasource.login(username, password);
      return Right(login);
    } catch (e) {
      return Left(ServerFailure(massage: e.toString()));
    }
  }
}
