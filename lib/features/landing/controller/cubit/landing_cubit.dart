import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:food_planner/core/network/failure.dart';
import 'package:food_planner/features/landing/data/model/category_model.dart';
import 'package:food_planner/features/landing/data/model/country_model.dart';
import 'package:food_planner/features/landing/data/repository/landing_repository.dart';

import '../../data/model/meal_model.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  final BaseLandingRepository baseLandingRepository;
  LandingCubit(this.baseLandingRepository)
      : super(LandingState(
            getMealOfTheDayStatus: GetMealOfTheDayStatus.initial,
            getCategoriesStatus: GetCategoriesStatus.initial,
            getCountriesStatus: GetCountriesStatus.initial));

  getMealOfTheDay() async {
    emit(state.copyWith(getMealOfTheDayStatus: GetMealOfTheDayStatus.loading));
    Either<ApiErrorModel, List<Meal>> result =
        await baseLandingRepository.getMealOfTheDay();
    result.fold((l) {
      emit(state.copyWith(
          getMealOfTheDayStatus: GetMealOfTheDayStatus.failure,
          errorMsg: l.message ?? 'Something went wrong',
          mealOfTheDay: state.mealOfTheDay));
    }, (r) {
      emit(state.copyWith(
          getMealOfTheDayStatus: GetMealOfTheDayStatus.success,
          mealOfTheDay: r[0]));
    });
  }

  getCategories() async {
    emit(state.copyWith(getCategoriesStatus: GetCategoriesStatus.loading));
    var result = await baseLandingRepository.getCategories();
    result.fold((l) {
      emit(state.copyWith(
          getCategoriesStatus: GetCategoriesStatus.failure,
          errorMsg: l.message ?? 'Something went wrong',
          categories: state.categories));
    }, (r) {
      emit(state.copyWith(
          getCategoriesStatus: GetCategoriesStatus.success, categories: r));
    });
  }

  getCountries() async {
    emit(state.copyWith(getCountriesStatus: GetCountriesStatus.loading));
    var result = await baseLandingRepository.getCountries();
    result.fold((l) {
      emit(state.copyWith(
          getCountriesStatus: GetCountriesStatus.failure,
          errorMsg: l.message ?? 'Something went wrong',
          countries: state.countries));
    }, (r) {
      emit(state.copyWith(
          getCountriesStatus: GetCountriesStatus.success, countries: r));
    });
  }
}
