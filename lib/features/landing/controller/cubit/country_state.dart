part of 'country_cubit.dart';

@immutable
sealed class CountryState {}

final class CountryInitial extends CountryState {}

final class GetMealsBasedOnCountryLoading extends CountryState {}

final class GetMealsBasedOnCountrySuccess extends CountryState {}

final class GetMealsBasedOnCountryError extends CountryState {
  final String errorMsg;

  GetMealsBasedOnCountryError(this.errorMsg);
}
