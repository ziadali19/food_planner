part of 'meal_cubit.dart';

@immutable
sealed class MealState {}

final class MealInitial extends MealState {}

final class GetMealByIdLoading extends MealState {}

final class GetMealByIdSuccess extends MealState {}

final class GetMealByIdError extends MealState {
  final String errorMsg;

  GetMealByIdError(this.errorMsg);
}
