import 'package:hive/hive.dart';

part 'meal_model.g.dart'; // This file will be generated

@HiveType(typeId: 0) // Define a unique typeId for the model
class Meal extends HiveObject {
  @HiveField(0)
  final String? idMeal;

  @HiveField(1)
  final String? strMeal;

  @HiveField(2)
  final String? strDrinkAlternate;

  @HiveField(3)
  final String? strCategory;

  @HiveField(4)
  final String? strArea;

  @HiveField(5)
  final String? strInstructions;

  @HiveField(6)
  final String? strMealThumb;

  @HiveField(7)
  final String? strTags;

  @HiveField(8)
  final String? strYoutube;

  @HiveField(9)
  final List<String?>? ingredients;

  @HiveField(10)
  final List<String?>? measures;

  @HiveField(11)
  final String? strSource;

  @HiveField(12)
  final String? strImageSource;

  @HiveField(13)
  final String? strCreativeCommonsConfirmed;

  @HiveField(14)
  final String? dateModified;

  Meal({
    this.idMeal,
    this.strMeal,
    this.strDrinkAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.ingredients,
    this.measures,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      idMeal: json['idMeal'] as String?,
      strMeal: json['strMeal'] as String?,
      strDrinkAlternate: json['strDrinkAlternate'] as String?,
      strCategory: json['strCategory'] as String?,
      strArea: json['strArea'] as String?,
      strInstructions: json['strInstructions'] as String?,
      strMealThumb: json['strMealThumb'] as String?,
      strTags: json['strTags'] as String?,
      strYoutube: json['strYoutube'] as String?,
      ingredients: List<String?>.generate(
          20, (index) => json['strIngredient${index + 1}'] as String?),
      measures: List<String?>.generate(
          20, (index) => json['strMeasure${index + 1}'] as String?),
      strSource: json['strSource'] as String?,
      strImageSource: json['strImageSource'] as String?,
      strCreativeCommonsConfirmed:
          json['strCreativeCommonsConfirmed'] as String?,
      dateModified: json['dateModified'] as String?,
    );
  }
}
