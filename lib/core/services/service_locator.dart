import 'package:get_it/get_it.dart';

import '../../features/auth/controller/cubit/login_cubit.dart';

import '../../features/auth/data/remote_data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repository/auth_repository.dart';
import '../network/dio_helper.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));

    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource(DioHelper.instance));
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));

    /*
    sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));

    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource(DioHelper.instance));
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));*/
  }
}
