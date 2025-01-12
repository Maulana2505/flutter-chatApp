import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/search/domain/entity/search_entity.dart';
import 'package:chatapp/features/search/domain/repository/search_repository.dart';

class SearchUsecase {
  final SearchRepository _searchRepository;
  SearchUsecase(this._searchRepository);
  ResultFuture<List<SearchEntity>> call(String query) async {
    return await _searchRepository.search(query);
  }
}
