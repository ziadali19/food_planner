import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_planner/core/helpers/extensions.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../landing/data/model/meal_model.dart';
import '../../../landing/presentation/components/meal_card.dart';
import '../../controller/cubit/favorites_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, List<Meal>>(
      builder: (context, favoriteMeals) {
        return Scaffold(
            appBar: AppBar(title: const Text('Favorites')),
            body: favoriteMeals.isEmpty
                ? Center(
                    child: Text(
                    'No favorite meals',
                    style: TextStyles.font20Black700,
                  ))
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: favoriteMeals.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return verticalSpace(20.h);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            context.pushNamed(Routes.favMeal,
                                arguments: favoriteMeals[index]);
                          },
                          child: MealCard(
                              mealObj: favoriteMeals[index],
                              title: favoriteMeals[index].strMeal ?? '',
                              image: favoriteMeals[index].strMealThumb ?? '',
                              country: favoriteMeals[index].strArea ?? ''),
                        );
                      },
                    ),
                  ));
      },
    );
  }
}
