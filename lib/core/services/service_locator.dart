import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    /*
    sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));

    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource(DioHelper.instance));
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));*/
  }
}
