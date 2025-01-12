import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/home/domain/entity/home_entity.dart';
import 'package:chatapp/features/home/domain/repository/home_repository.dart';

class HomeUsecase {
  final HomeRepository _homeRepository;
  HomeUsecase(this._homeRepository);
  ResultFuture<List<HomeEntity>> call() async {
    return await _homeRepository.home();
  }
}
