

import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/home/domain/entity/home_entity.dart';

abstract class HomeRepository {
  ResultFuture<List<HomeEntity>> home();
}