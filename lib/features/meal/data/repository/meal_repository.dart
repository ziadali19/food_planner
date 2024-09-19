import 'package:dartz/dartz.dart';
import 'package:food_planner/features/landing/data/model/meal_model.dart';

import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/exceptions.dart';
import '../../../../core/network/failure.dart';
import '../remote_data_source/meal_remota_data_source.dart';

abstract class BaseMealRepository {
  Future<Either<ApiErrorModel, Meal>> getMealById(String mealId);
}

class MealRepository extends BaseMealRepository {
  final BaseMealRemoteDataSource baseMealRemoteDataSource;

  MealRepository(this.baseMealRemoteDataSource);

  @override
  Future<Either<ApiErrorModel, Meal>> getMealById(String mealId) async {
    try {
      var response = await baseMealRemoteDataSource.getMealById(mealId);
      return right(response);
    } on NetworkException catch (e) {
      ApiErrorModel apiErrorModel =
          ErrorHandler.instance.handleError(e.dioException);

      return left(apiErrorModel);
    }
  }
}
