import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:food_planner/core/network/failure.dart';
import 'package:food_planner/features/landing/data/repository/templates_repository.dart';
import 'package:meta/meta.dart';

import '../../data/model/meal_model.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  final BaseLandingRepository baseLandingRepository;
  LandingCubit(this.baseLandingRepository) : super(LandingInitial());
  Meal? mealOfTheDay;
  getMealOfTheDay() async {
    emit(GetMealOfTheDayLoading());
    Either<ApiErrorModel, List<Meal>> result =
        await baseLandingRepository.getMealOfTheDay();
    result.fold((l) {
      emit(GetMealOfTheDayError(l.message ?? 'Something went wrong'));
    }, (r) {
      mealOfTheDay = r[0];
      emit(GetMealOfTheDaySuccess());
    });
  }
}
