import 'package:bloc/bloc.dart';
import 'package:food_planner/features/search/data/repository/search_repository.dart';
import 'package:meta/meta.dart';

import '../../data/model/meal_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final BaseSearchRepository baseSearchRepository;
  CategoryCubit(this.baseSearchRepository) : super(CategoryInitial());
  List<Meal>? meals;
  getMealsBasedOnCategory(String categoryName) async {
    emit(GetMealsBasedOnCategoryLoading());
    var result =
        await baseSearchRepository.getSearchedMeals(categoryName, 'Category');
    result.fold((l) {
      emit(GetMealsBasedOnCategoryError(l.message ?? 'Something went wrong'));
    }, (r) {
      meals = r;
      emit(GetMealsBasedOnCategorySuccess());
    });
  }
}
