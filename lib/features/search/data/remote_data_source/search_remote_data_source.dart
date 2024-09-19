import 'package:dio/dio.dart';
import 'package:food_planner/features/landing/data/model/meal_model.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/exceptions.dart';

abstract class BaseSearchRemoteDataSource {
  Future<List<Meal>> getSearchedMeals(String query, String criteria);
}

class SearchRemoteDataSource extends BaseSearchRemoteDataSource {
  final DioHelper dioHelper;
  SearchRemoteDataSource(this.dioHelper);
  @override
  Future<List<Meal>> getSearchedMeals(String query, String criteria) async {
    String key = '';
    switch (criteria) {
      case 'Category':
        key = 'c';
      case 'Country':
        key = 'a';
      case 'Ingredient':
        key = 'i';
      default:
        key = 'c';
    }
    try {
      final Response response =
          await dioHelper.get("filter.php", queryParameters: {
        key: query,
      });
      return (response.data['meals']) != null
          ? (response.data['meals'] as List)
              .map((e) => Meal.fromJson(e))
              .toList()
          : [];
    } on DioException catch (e) {
      throw NetworkException(dioException: e);
    }
  }
}
