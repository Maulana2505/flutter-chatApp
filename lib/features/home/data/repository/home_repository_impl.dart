import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/home/data/datasource/remote/home_datasource.dart';
import 'package:chatapp/features/home/domain/entity/home_entity.dart';
import 'package:chatapp/features/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDatasource _homeRemoteDatasource;
  HomeRepositoryImpl(this._homeRemoteDatasource);
  @override
  ResultFuture<List<HomeEntity>> home() async {
    try {
      final data = await _homeRemoteDatasource.get();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(massage: e.toString()));
    }
  }
}
