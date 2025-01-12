// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/auth/signup/data/datasource/remoteDataSource/signup_datasouce.dart';
import 'package:chatapp/features/auth/signup/domain/repository/signup_repository.dart';
import 'package:dartz/dartz.dart';

class SignupRepositoryImpl extends SignupRepository {
  final SignupDatasouce signupDatasouce;
  SignupRepositoryImpl({
    required this.signupDatasouce,
  });

  @override
  ResultVoid signUp(String username, String password, String confirmPassword,
      String gender) async {
    try {
      final data = await signupDatasouce.signup(
          username, password, confirmPassword, gender);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(massage: e.toString()));
    }
  }
}
