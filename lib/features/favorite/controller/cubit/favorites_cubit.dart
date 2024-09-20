import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:food_planner/core/helpers/show_toast.dart';
import 'package:hive/hive.dart';
import '../../../../core/utils/constants.dart';
import '../../../landing/data/model/meal_model.dart';
// Import your Meal model

class FavoritesCubit extends Cubit<List<Meal>> {
  FavoritesCubit() : super([]);

  final Box<Meal> _favoritesBox = Hive.box<Meal>('favorites');

  // Load favorite meals from Hive storage
  void loadFavorites() {
    emit(_favoritesBox.values.toList());
  }

  // Add a meal to favorites
  void addMealToFavorites(Meal meal, BuildContext context) {
    if (AppConstants.isGuest) {
      showSnackBar('Please login to add meals to favorites', context, false);
      return;
    }
    _favoritesBox.put(meal.idMeal, meal);
    loadFavorites();
  }

  // Remove a meal from favorites
  void removeMealFromFavorites(Meal meal) {
    _favoritesBox.delete(meal.idMeal);
    loadFavorites();
  }

  // Check if a meal is already in favorites
  bool isFavorite(String mealId) {
    return _favoritesBox.containsKey(mealId);
  }

  Future<void> clearFavorites() async {
    final box = Hive.box<Meal>('favorites');
    await box.clear();
    emit(_favoritesBox.values.toList());
  }
}
