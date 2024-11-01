import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_planner/features/auth/controller/cubit/register_cubit.dart';
import 'package:food_planner/features/landing/controller/cubit/landing_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/auth/controller/cubit/login_cubit.dart';

import '../../features/auth/data/remote_data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/landing/controller/cubit/category_cubit.dart';
import '../../features/landing/controller/cubit/country_cubit.dart';
import '../../features/landing/data/remote_data_source/landing_remota_data_source.dart';
import '../../features/landing/data/repository/landing_repository.dart';
import '../../features/meal/controller/cubit/meal_cubit.dart';
import '../../features/meal/data/remote_data_source/meal_remota_data_source.dart';
import '../../features/meal/data/repository/meal_repository.dart';
import '../../features/search/controller/cubit/search_cubit.dart';
import '../../features/search/data/remote_data_source/search_remote_data_source.dart';
import '../../features/search/data/repository/search_repository.dart';
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
//
    sl.registerFactory<LandingCubit>(() => LandingCubit(sl()));
    sl.registerFactory<CategoryCubit>(() => CategoryCubit(sl()));
    sl.registerFactory<CountryCubit>(() => CountryCubit(sl()));
    sl.registerLazySingleton<BaseLandingRemoteDataSource>(
        () => LandingRemoteDataSource(DioHelper.instance));
    sl.registerLazySingleton<BaseLandingRepository>(
        () => LandingRepository(sl()));

    //search
    sl.registerFactory<SearchCubit>(() => SearchCubit(sl()));
    sl.registerLazySingleton<BaseSearchRemoteDataSource>(
        () => SearchRemoteDataSource(DioHelper.instance));
    sl.registerLazySingleton<BaseSearchRepository>(
        () => SearchRepository(sl()));
    //meal
    sl.registerFactory<MealCubit>(() => MealCubit(sl()));
    sl.registerLazySingleton<BaseMealRemoteDataSource>(
        () => MealRemoteDataSource(DioHelper.instance));
    sl.registerLazySingleton<BaseMealRepository>(() => MealRepository(sl()));
  }
}
