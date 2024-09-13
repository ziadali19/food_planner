import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_planner/core/helpers/show_toast.dart';
import 'package:food_planner/core/helpers/spacing.dart';
import 'package:food_planner/core/theming/colors.dart';
import 'package:food_planner/features/landing/controller/cubit/landing_cubit.dart';
import 'package:food_planner/features/landing/presentation/components/meal_card.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/constants.dart';
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
      create: (context) => sl<LandingCubit>()..getMealOfTheDay(),
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
                                      ''), // Display the initials
                                  style: TextStyles.font18Black500),
                            ),
                            horizontalSpace(8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${'Welcome'} ${AppConstants.name}',
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
                              current is GetMealOfTheDaySuccess ||
                              current is GetMealOfTheDayError ||
                              current is GetMealOfTheDayLoading,
                          listener: (context, state) {
                            if (state is GetMealOfTheDayError) {
                              showSnackBar(state.errorMsg, context, false);
                            }
                          },
                          builder: (context, state) {
                            LandingCubit cubit = context.read<LandingCubit>();
                            if (cubit.mealOfTheDay == null) {
                              return const ShimmerItemForMeals(itemCount: 1);
                            }
                            if (cubit.mealOfTheDay != null) {
                              return MealCard(
                                  title: cubit.mealOfTheDay!.strMeal ?? '',
                                  image: cubit.mealOfTheDay!.strMealThumb ?? '',
                                  country: cubit.mealOfTheDay!.strArea ?? '');
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
