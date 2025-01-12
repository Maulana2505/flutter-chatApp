import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/search/data/datasource/remote/search_datasource.dart';

import 'package:chatapp/features/search/domain/entity/search_entity.dart';
import 'package:chatapp/features/search/domain/repository/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchDatasource _searchDatasource;
  SearchRepositoryImpl(this._searchDatasource);

  @override
  ResultFuture<List<SearchEntity>> search(String query) async {
    try {
      final data = await _searchDatasource.get(query);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(massage: e.toString()));
    }
  }
} 
