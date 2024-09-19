part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class GetMealsBasedOnCategoryLoading extends CategoryState {}

final class GetMealsBasedOnCategorySuccess extends CategoryState {}

final class GetMealsBasedOnCategoryError extends CategoryState {
  final String errorMsg;

  GetMealsBasedOnCategoryError(this.errorMsg);
}
