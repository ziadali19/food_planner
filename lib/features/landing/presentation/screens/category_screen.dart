import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_planner/core/helpers/extensions.dart';

import '../../../../core/helpers/show_toast.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../controller/cubit/category_cubit.dart';
import '../components/meal_card.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    context.read<CategoryCubit>().getMealsBasedOnCategory(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is GetMealsBasedOnCategoryError) {
          showSnackBar(state.errorMsg, context, false);
        }
      },
      builder: (context, state) {
        CategoryCubit cubit = context.read<CategoryCubit>();
        if (state is GetMealsBasedOnCategorySuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.categoryName.toUpperCase(),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.meals!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return verticalSpace(20.h);
                },
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      context.pushNamed(Routes.meal,
                          arguments: cubit.meals![index].idMeal);
                    },
                    child: MealCard(
                        mealObj: cubit.meals![index],
                        title: cubit.meals![index].strMeal ?? '',
                        image: cubit.meals![index].strMealThumb ?? '',
                        country: cubit.meals![index].strArea ?? ''),
                  );
                },
              ),
            ),
          );
        }
        if (state is GetMealsBasedOnCategoryLoading) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is GetMealsBasedOnCategoryError) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Center(
                  child: Text(
                state.errorMsg,
                textAlign: TextAlign.center,
                style: TextStyles.font20Black700,
              )),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
