import 'package:dio/dio.dart';
import 'package:food_planner/core/network/dio_helper.dart';
import 'package:food_planner/features/landing/data/model/category_model.dart';
import 'package:food_planner/features/landing/data/model/meal_model.dart';

import '../../../../core/network/exceptions.dart';
import '../model/country_model.dart';

abstract class BaseLandingRemoteDataSource {
  Future<List<Meal>> getMealOfTheDay();
  Future<List<Category>> getCategories();
  Future<List<Country>> getCountries();
}

class LandingRemoteDataSource implements BaseLandingRemoteDataSource {
  final DioHelper dioHelper;
  LandingRemoteDataSource(this.dioHelper);
  @override
  Future<List<Meal>> getMealOfTheDay() async {
    try {
      final Response response = await dioHelper.get("random.php");
      return (response.data['meals'] as List)
          .map((e) => Meal.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw NetworkException(dioException: e);
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final Response response = await dioHelper.get("categories.php");
      return (response.data['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw NetworkException(dioException: e);
    }
  }

  @override
  Future<List<Country>> getCountries() async {
    try {
      final Response response = await dioHelper.get("list.php?a=list");
      return (response.data['meals'] as List)
          .map((e) => Country.fromMap(e))
          .toList();
    } on DioException catch (e) {
      throw NetworkException(dioException: e);
    }
  }
}
