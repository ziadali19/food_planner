part of 'landing_cubit.dart';

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
