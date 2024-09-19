import 'package:dio/dio.dart';
import 'package:food_planner/core/network/dio_helper.dart';

import 'package:food_planner/features/landing/data/model/meal_model.dart';

import '../../../../core/network/exceptions.dart';

abstract class BaseMealRemoteDataSource {
  Future<Meal> getMealById(String mealId);
}

class MealRemoteDataSource implements BaseMealRemoteDataSource {
  final DioHelper dioHelper;
  MealRemoteDataSource(this.dioHelper);
  @override
  Future<Meal> getMealById(String mealId) async {
    try {
      final Response response =
          await dioHelper.get("lookup.php", queryParameters: {"i": mealId});
      return (response.data['meals'] as List)
          .map((e) => Meal.fromJson(e))
          .toList()
          .first;
    } on DioException catch (e) {
      throw NetworkException(dioException: e);
    }
  }
}
