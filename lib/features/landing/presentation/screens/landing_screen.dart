import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_planner/core/helpers/extensions.dart';
import 'package:food_planner/core/helpers/show_toast.dart';
import 'package:food_planner/core/helpers/spacing.dart';
import 'package:food_planner/core/routing/routes.dart';
import 'package:food_planner/core/theming/colors.dart';
import 'package:food_planner/features/landing/controller/cubit/landing_cubit.dart';
import 'package:food_planner/features/landing/presentation/components/meal_card.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/constants.dart';

import '../components/category_widget.dart';
import '../components/country_widget.dart';
import '../components/shimmer_for_meals.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LandingCubit>()
        ..getMealOfTheDay()
        ..getCategories()
        ..getCountries(),
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25.r,
                              backgroundColor: Colors
                                  .grey[200], // Set a color for the background
                              child: Text(
                                  AppConstants.getInitials(AppConstants.name ??
                                      'Guest'), // Display the initials
                                  style: TextStyles.font18Black500),
                            ),
                            horizontalSpace(8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${'Welcome'} ${AppConstants.name ?? 'Guest'}',
                                    overflow: TextOverflow
                                        .ellipsis, // Handle long names
                                    style: TextStyles.font18Black500,
                                  ),
                                  SizedBox(height: 4.0.h),

                                  // Last Message
                                  Text(
                                    DateFormat.MEd().format(DateTime.now()),
                                    overflow: TextOverflow
                                        .ellipsis, // Handle long messages
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: ColorsManager.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(20.h),
                        Divider(
                          color: ColorsManager.primary,
                          thickness: 2.w,
                        ),
                        verticalSpace(20.h),
                        Text('Meal of the day',
                            style: TextStyles.font24Black700),
                        verticalSpace(20.h),
                        BlocConsumer<LandingCubit, LandingState>(
                          buildWhen: (previous, current) =>
                              current.getMealOfTheDayStatus !=
                              previous.getMealOfTheDayStatus,
                          listener: (context, state) {
                            if (state.getMealOfTheDayStatus.isFailure) {
                              showSnackBar(state.errorMsg, context, false);
                            }
                          },
                          builder: (context, state) {
                            if (state.getMealOfTheDayStatus.isLoading) {
                              return const ShimmerItemForMeals(itemCount: 1);
                            }
                            if (state.getMealOfTheDayStatus.isSuccess) {
                              return InkWell(
                                onTap: () {
                                  context.pushNamed(Routes.meal,
                                      arguments: state.mealOfTheDay!.idMeal);
                                },
                                child: MealCard(
                                    mealObj: state.mealOfTheDay!,
                                    title: state.mealOfTheDay!.strMeal ?? '',
                                    image:
                                        state.mealOfTheDay!.strMealThumb ?? '',
                                    country: state.mealOfTheDay!.strArea ?? ''),
                              );
                            }
                            if (state.getMealOfTheDayStatus.isFailure) {
                              if (state.mealOfTheDay == null) {
                                return Center(
                                  child: Text(
                                      state.errorMsg ?? 'Something went wrong'),
                                );
                              } else {
                                return MealCard(
                                    mealObj: state.mealOfTheDay!,
                                    title: state.mealOfTheDay!.strMeal ?? '',
                                    image:
                                        state.mealOfTheDay!.strMealThumb ?? '',
                                    country: state.mealOfTheDay!.strArea ?? '');
                              }
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        verticalSpace(20.h),
                        Text('Categories', style: TextStyles.font24Black700),
                        verticalSpace(10.h),
                        RefreshIndicator(
                          onRefresh: () async {
                            context.read<LandingCubit>().getCategories();
                          },
                          child: BlocConsumer<LandingCubit, LandingState>(
                            buildWhen: (previous, current) =>
                                current.getCategoriesStatus !=
                                previous.getCategoriesStatus,
                            listener: (context, state) {
                              if (state.getCategoriesStatus.isFailure) {
                                showSnackBar(state.errorMsg, context, false);
                              }
                            },
                            builder: (context, state) {
                              if (state.getCategoriesStatus.isLoading) {
                                return const ShimmerItemForMeals(itemCount: 1);
                              }
                              if (state.getCategoriesStatus.isSuccess) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: List.generate(
                                          state.categories!.length,
                                          (index) => GestureDetector(
                                                onTap: () {
                                                  context.pushNamed(
                                                      Routes.category,
                                                      arguments: state
                                                          .categories![index]
                                                          .strCategory);
                                                },
                                                child: CategoryWidget(
                                                  categoryThumb: state
                                                          .categories![index]
                                                          .strCategoryThumb ??
                                                      '',
                                                  categoryName: state
                                                          .categories![index]
                                                          .strCategory ??
                                                      '',
                                                ),
                                              ))),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        verticalSpace(20.h),
                        Text('Countries', style: TextStyles.font24Black700),
                        verticalSpace(10.h),
                        BlocConsumer<LandingCubit, LandingState>(
                          buildWhen: (previous, current) =>
                              current.getCountriesStatus !=
                              previous.getCountriesStatus,
                          listener: (context, state) {
                            if (state.getCountriesStatus.isFailure) {
                              showSnackBar(state.errorMsg, context, false);
                            }
                          },
                          builder: (context, state) {
                            if (state.getCountriesStatus.isLoading) {
                              return const ShimmerItemForMeals(itemCount: 1);
                            }
                            if (state.getCountriesStatus.isSuccess) {
                              return Wrap(
                                direction: Axis.horizontal,
                                children: List.generate(
                                    state.countries!.length,
                                    (index) => InkWell(
                                          onTap: () {
                                            context.pushNamed(Routes.country,
                                                arguments: state
                                                    .countries![index].strArea);
                                          },
                                          child: CountryWidget(
                                            country: state.countries![index]
                                                    .strArea ??
                                                '',
                                          ),
                                        )),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        )
                      ],
                    )))),
      ),
    );
  }
}
