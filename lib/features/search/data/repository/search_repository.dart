import 'package:dartz/dartz.dart';
import 'package:food_planner/core/network/failure.dart';
import 'package:food_planner/features/search/data/remote_data_source/search_remote_data_source.dart';

import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/exceptions.dart';
import '../../../landing/data/model/meal_model.dart';

abstract class BaseSearchRepository {
  Future<Either<ApiErrorModel, List<Meal>>> getSearchedMeals(
      String query, String criteria);
}

class SearchRepository extends BaseSearchRepository {
  final BaseSearchRemoteDataSource baseSearchRemoteDataSource;

  SearchRepository(this.baseSearchRemoteDataSource);
  @override
  Future<Either<ApiErrorModel, List<Meal>>> getSearchedMeals(
      String query, String criteria) async {
    try {
      var response =
          await baseSearchRemoteDataSource.getSearchedMeals(query, criteria);
      return right(response);
    } on NetworkException catch (e) {
      ApiErrorModel apiErrorModel =
          ErrorHandler.instance.handleError(e.dioException);

      return left(apiErrorModel);
    }
  }
}
