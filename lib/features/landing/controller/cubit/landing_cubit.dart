import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:food_planner/core/network/failure.dart';
import 'package:food_planner/features/landing/data/model/category_model.dart';
import 'package:food_planner/features/landing/data/model/country_model.dart';
import 'package:food_planner/features/landing/data/repository/landing_repository.dart';
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

  List<Category>? categories;
  getCategories() async {
    emit(GetCategoriesLoading());
    var result = await baseLandingRepository.getCategories();
    result.fold((l) {
      emit(GetCategoriesError(l.message ?? 'Something went wrong'));
    }, (r) {
      categories = r;
      emit(GetCategoriesSuccess());
    });
  }

  List<Country>? countries;
  getCountries() async {
    emit(GetCountriesLoading());
    var result = await baseLandingRepository.getCountries();
    result.fold((l) {
      emit(GetCountriesError(l.message ?? 'Something went wrong'));
    }, (r) {
      countries = r;
      emit(GetCountriesSuccess());
    });
  }
}
