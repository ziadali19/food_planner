import 'package:dio/dio.dart';
import 'package:food_planner/core/network/dio_helper.dart';
import 'package:food_planner/features/landing/data/model/meal_model.dart';

import '../../../../core/network/exceptions.dart';

abstract class BaseLandingRemoteDataSource {
  Future<List<Meal>> getMealOfTheDay();
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
}
