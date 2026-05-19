import '../classes/crud.dart';
import 'package:get_it/get_it.dart';
import '../../features/users/auth/data/repository/auth_repository.dart';
import '../../features/users/home/data/datasource/home_data_source.dart';
import '../../features/users/home/data/repository/home_data_repository.dart';
import '../../features/users/auth/data/datasource/remote/auth_remote_data_source.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    sl.registerLazySingleton<Crud>(() => Crud());
    sl.registerLazySingleton<IAuthRemoteDataSource>(
      () => AuthRemoteDataSource(crud: sl()),
    );
    sl.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(remoteDataSource: sl()),
    );
    sl.registerFactory<IHomeRepository>(() => HomeDatasource(crud: sl()));
  }
}
