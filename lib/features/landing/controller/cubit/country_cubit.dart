import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../search/data/repository/search_repository.dart';
import '../../data/model/meal_model.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final BaseSearchRepository baseSearchRepository;
  CountryCubit(this.baseSearchRepository) : super(CountryInitial());
  List<Meal>? meals;
  getMealsBasedOnCountry(String countryName) async {
    emit(GetMealsBasedOnCountryLoading());
    var result =
        await baseSearchRepository.getSearchedMeals(countryName, 'Country');
    result.fold((l) {
      emit(GetMealsBasedOnCountryError(l.message ?? 'Something went wrong'));
    }, (r) {
      meals = r;
      emit(GetMealsBasedOnCountrySuccess());
    });
  }
}
