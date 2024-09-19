import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_planner/core/helpers/extensions.dart';
import 'package:food_planner/features/landing/controller/cubit/country_cubit.dart';

import '../../../../core/helpers/show_toast.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../components/meal_card.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key, required this.countryName});
  final String countryName;
  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  void initState() {
    context.read<CountryCubit>().getMealsBasedOnCountry(widget.countryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CountryCubit, CountryState>(
      listener: (context, state) {
        if (state is GetMealsBasedOnCountryError) {
          showSnackBar(state.errorMsg, context, false);
        }
      },
      builder: (context, state) {
        CountryCubit cubit = context.read<CountryCubit>();
        if (state is GetMealsBasedOnCountrySuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.countryName.toUpperCase(),
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
                        title: cubit.meals![index].strMeal ?? '',
                        image: cubit.meals![index].strMealThumb ?? '',
                        country: cubit.meals![index].strArea ?? ''),
                  );
                },
              ),
            ),
          );
        }
        if (state is GetMealsBasedOnCountryLoading) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is GetMealsBasedOnCountryError) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Expanded(
                  child: Center(
                      child: Text(
                state.errorMsg,
                style: TextStyles.font20Black700,
              ))),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
