import 'package:dartz/dartz.dart';
import 'package:food_planner/features/landing/data/model/meal_model.dart';

import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/exceptions.dart';
import '../../../../core/network/failure.dart';
import '../remote_data_source/landing_remota_data_source.dart';

abstract class BaseLandingRepository {
  Future<Either<ApiErrorModel, List<Meal>>> getMealOfTheDay();
}

class LandingRepository extends BaseLandingRepository {
  final BaseLandingRemoteDataSource baseLandingRemoteDataSource;

  LandingRepository(this.baseLandingRemoteDataSource);

  @override
  Future<Either<ApiErrorModel, List<Meal>>> getMealOfTheDay() async {
    try {
      var response = await baseLandingRemoteDataSource.getMealOfTheDay();
      return right(response);
    } on NetworkException catch (e) {
      ApiErrorModel apiErrorModel =
          ErrorHandler.instance.handleError(e.dioException);

      return left(apiErrorModel);
    }
  }
}
