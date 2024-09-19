part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class GetSearchedMealsLoading extends SearchState {}

final class GetSearchedMealsSuccess extends SearchState {}

final class GetSearchedMealsError extends SearchState {
  final String errorMsg;

  GetSearchedMealsError(this.errorMsg);
}

final class ClearSearch extends SearchState {}

final class SelectCriteria extends SearchState {}
