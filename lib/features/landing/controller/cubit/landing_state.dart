part of 'landing_cubit.dart';

enum GetMealOfTheDayStatus { initial, loading, success, failure }

enum GetCategoriesStatus { initial, loading, success, failure }

enum GetCountriesStatus { initial, loading, success, failure }

extension GetMealOfTheDayStatusX on GetMealOfTheDayStatus {
  bool get isInitial => this == GetMealOfTheDayStatus.initial;
  bool get isLoading => this == GetMealOfTheDayStatus.loading;
  bool get isSuccess => this == GetMealOfTheDayStatus.success;
  bool get isFailure => this == GetMealOfTheDayStatus.failure;
}

extension GetCategoriesStatusX on GetCategoriesStatus {
  bool get isInitial => this == GetCategoriesStatus.initial;
  bool get isLoading => this == GetCategoriesStatus.loading;
  bool get isSuccess => this == GetCategoriesStatus.success;
  bool get isFailure => this == GetCategoriesStatus.failure;
}

extension GetCountriesStatusX on GetCountriesStatus {
  bool get isInitial => this == GetCountriesStatus.initial;
  bool get isLoading => this == GetCountriesStatus.loading;
  bool get isSuccess => this == GetCountriesStatus.success;
  bool get isFailure => this == GetCountriesStatus.failure;
}

class LandingState {
  final GetMealOfTheDayStatus getMealOfTheDayStatus;
  final GetCategoriesStatus getCategoriesStatus;
  final GetCountriesStatus getCountriesStatus;
  final String? errorMsg;
  final Meal? mealOfTheDay;
  final List<Category>? categories;
  final List<Country>? countries;

  LandingState(
      {required this.getMealOfTheDayStatus,
      required this.getCategoriesStatus,
      required this.getCountriesStatus,
      this.errorMsg,
      this.mealOfTheDay,
      this.categories,
      this.countries});

  copyWith({
    GetMealOfTheDayStatus? getMealOfTheDayStatus,
    GetCategoriesStatus? getCategoriesStatus,
    GetCountriesStatus? getCountriesStatus,
    String? errorMsg,
    Meal? mealOfTheDay,
    List<Category>? categories,
    List<Country>? countries,
  }) =>
      LandingState(
          getMealOfTheDayStatus:
              getMealOfTheDayStatus ?? this.getMealOfTheDayStatus,
          getCategoriesStatus: getCategoriesStatus ?? this.getCategoriesStatus,
          getCountriesStatus: getCountriesStatus ?? this.getCountriesStatus,
          errorMsg: errorMsg ?? this.errorMsg,
          mealOfTheDay: mealOfTheDay ?? this.mealOfTheDay,
          categories: categories ?? this.categories,
          countries: countries ?? this.countries);
}
/*
@immutable
sealed class LandingState {}

final class LandingInitial extends LandingState {}

final class GetMealOfTheDayLoading extends LandingState {}

final class GetMealOfTheDaySuccess extends LandingState {}

final class GetMealOfTheDayError extends LandingState {
  final String errorMsg;

  GetMealOfTheDayError(this.errorMsg);
}

final class GetCategoriesLoading extends LandingState {}

final class GetCategoriesSuccess extends LandingState {}

final class GetCategoriesError extends LandingState {
  final String errorMsg;

  GetCategoriesError(this.errorMsg);
}

final class GetCountriesLoading extends LandingState {}

final class GetCountriesSuccess extends LandingState {}

final class GetCountriesError extends LandingState {
  final String errorMsg;

  GetCountriesError(this.errorMsg);
}
*/