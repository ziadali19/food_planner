import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_planner/features/auth/controller/cubit/register_cubit.dart';
import 'package:food_planner/features/landing/controller/cubit/landing_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/auth/controller/cubit/login_cubit.dart';

import '../../features/auth/data/remote_data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/landing/data/remote_data_source/landing_remota_data_source.dart';
import '../../features/landing/data/repository/templates_repository.dart';
import '../network/dio_helper.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl(), sl()));
    sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl(), sl()));
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource(DioHelper.instance));
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));

    sl.registerFactory<LandingCubit>(() => LandingCubit(sl()));

    sl.registerLazySingleton<BaseLandingRemoteDataSource>(
        () => LandingRemoteDataSource(DioHelper.instance));
    sl.registerLazySingleton<BaseLandingRepository>(
        () => LandingRepository(sl()));
  }
}
