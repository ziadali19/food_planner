import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_planner/core/helpers/extensions.dart';
import 'package:food_planner/core/helpers/show_toast.dart';
import 'package:food_planner/features/landing/presentation/components/meal_card.dart';
import 'package:food_planner/features/search/controller/cubit/search_cubit.dart';
import 'package:food_planner/features/search/presentation/components/filter_item.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../landing/presentation/components/shimmer_for_meals.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('SEARCH')),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      SearchCubit cubit = context.read<SearchCubit>();
                      return Expanded(
                        child: SearchBar(
                          onSubmitted: (value) {
                            cubit.getSearchedMeals(
                                value.trim(), cubit.selectedCriteria);
                          },
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          hintStyle: WidgetStatePropertyAll(
                              TextStyles.font16Black500.copyWith(
                                  color: Colors.black.withOpacity(0.42),
                                  fontWeight: FontWeight.w400)),
                          hintText: 'Search for meals ...',
                          controller: searchController,
                          trailing: [
                            IconButton(
                                onPressed: () {
                                  searchController.clear();
                                  cubit.clearSearchedMeals();
                                },
                                icon: SvgPicture.asset('deleteText'.svgPath()))
                          ],
                          leading: SvgPicture.asset('search'.svgPath()),
                          constraints: BoxConstraints.tight(
                              Size(MediaQuery.sizeOf(context).width, 50.h)),
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          elevation: const WidgetStatePropertyAll(0),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r))),
                          side: const WidgetStatePropertyAll(
                              BorderSide(color: ColorsManager.primary)),
                        ),
                      );
                    },
                  ),
                  horizontalSpace(10.w),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (ctx, state) {
                      SearchCubit cubit = ctx.read<SearchCubit>();
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  child: SingleChildScrollView(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Criteria',
                                              style: TextStyles.font24Black500),
                                          verticalSpace(10.h),
                                          Wrap(
                                            children: List.generate(
                                                cubit.criteriaItems.length,
                                                (index) => FilterItem(
                                                    onTap: () {
                                                      setState(() {
                                                        cubit.selectCriteria(
                                                            cubit.criteriaItems[
                                                                index]);
                                                      });
                                                    },
                                                    containerBgColor: cubit
                                                                    .criteriaItems[
                                                                index] ==
                                                            cubit
                                                                .selectedCriteria
                                                        ? ColorsManager.primary
                                                        : ColorsManager
                                                            .secondary,
                                                    containerTextColor: cubit
                                                                    .criteriaItems[
                                                                index] ==
                                                            cubit
                                                                .selectedCriteria
                                                        ? Colors.white
                                                        : Colors.black,
                                                    name: cubit
                                                        .criteriaItems[index])),
                                          ),
                                          verticalSpace(20.h)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: ColorsManager.secondary),
                          child: Text(
                            cubit.selectedCriteria,
                            style: TextStyles.font16Black500
                                .copyWith(color: ColorsManager.primary),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              verticalSpace(20.h),
              BlocConsumer<SearchCubit, SearchState>(
                listener: (context, state) {
                  if (state is GetSearchedMealsError) {
                    showSnackBar(state.errorMsg, context, false);
                  }
                },
                builder: (context, state) {
                  SearchCubit cubit = context.read<SearchCubit>();
                  if (state is GetSearchedMealsLoading) {
                    return const ShimmerItemForMeals(
                      itemCount: 2,
                    );
                  }
                  if (state is GetSearchedMealsSuccess) {
                    if (cubit.searchedMeals!.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'No results found',
                            style: TextStyles.font20Black700,
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: cubit.searchedMeals!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return verticalSpace(20.h);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                context.pushNamed(Routes.meal,
                                    arguments:
                                        cubit.searchedMeals![index].idMeal);
                              },
                              child: MealCard(
                                  mealObj: cubit.searchedMeals![index],
                                  title:
                                      cubit.searchedMeals![index].strMeal ?? '',
                                  image: cubit
                                          .searchedMeals![index].strMealThumb ??
                                      '',
                                  country:
                                      cubit.searchedMeals![index].strArea ??
                                          ''),
                            );
                          },
                        ),
                      );
                    }
                  }
                  if (state is GetSearchedMealsError) {
                    return Expanded(
                        child: Center(
                            child: Text(
                      state.errorMsg,
                      style: TextStyles.font20Black700,
                    )));
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
