class Meal {
  final String? idMeal;
  final String? strMeal;
  final String? strDrinkAlternate;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final List<String?>? ingredients;
  final List<String?>? measures;
  final String? strSource;
  final String? strImageSource;
  final String? strCreativeCommonsConfirmed;
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
