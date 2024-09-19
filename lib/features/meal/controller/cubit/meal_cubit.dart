import 'package:bloc/bloc.dart';
import 'package:food_planner/features/landing/data/model/meal_model.dart';
import 'package:food_planner/features/meal/data/repository/meal_repository.dart';
import 'package:meta/meta.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  final BaseMealRepository baseMealRepository;
  MealCubit(this.baseMealRepository) : super(MealInitial());
  Meal? meal;
  getMealById(String mealId) async {
    emit(GetMealByIdLoading());
    var result = await baseMealRepository.getMealById(mealId);
    result.fold((l) {
      emit(GetMealByIdError(l.message ?? 'Something went wrong'));
    }, (r) {
      meal = r;
      emit(GetMealByIdSuccess());
    });
  }
}
