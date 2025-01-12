

import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/search/domain/entity/search_entity.dart';

abstract class SearchRepository{
  ResultFuture<List<SearchEntity>> search(String query);
}