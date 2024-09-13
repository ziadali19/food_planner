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
