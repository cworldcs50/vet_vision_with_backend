import 'package:get_it/get_it.dart';

import '../../features/users/home/data/datasource/home_data_source.dart';
import '../../features/users/home/data/repository/home_data_repository.dart';
import '../classes/crud.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    sl.registerLazySingleton<Crud>(() => Crud());
    sl.registerFactory<IHomeRepository>(() => HomeDatasource(crud: sl()));
  }
}
