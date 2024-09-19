import 'package:bloc/bloc.dart';
import 'package:food_planner/features/landing/data/model/meal_model.dart';
import 'package:food_planner/features/search/data/repository/search_repository.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final BaseSearchRepository baseSearchRepository;
  SearchCubit(this.baseSearchRepository) : super(SearchInitial());

  List<String> criteriaItems = [
    'Country',
    'Category',
    'Ingredient',
  ];
  String selectedCriteria = 'Country';

  selectCriteria(String criteria) {
    selectedCriteria = criteria;
    emit(SelectCriteria());
  }

  List<Meal>? searchedMeals;
  getSearchedMeals(String query, String criteria) async {
    emit(GetSearchedMealsLoading());
    var result = await baseSearchRepository.getSearchedMeals(query, criteria);
    result.fold((l) {
      emit(GetSearchedMealsError(l.message ?? 'Something went wrong'));
    }, (r) {
      searchedMeals = r;
      emit(GetSearchedMealsSuccess());
    });
  }

  clearSearchedMeals() {
    searchedMeals = null;
    emit(ClearSearch());
  }
}
