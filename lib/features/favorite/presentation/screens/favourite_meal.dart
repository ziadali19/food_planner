import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_planner/core/helpers/extensions.dart';
import 'package:food_planner/core/helpers/spacing.dart';
import 'package:food_planner/features/favorite/controller/cubit/favorites_cubit.dart';
import 'package:food_planner/features/landing/data/model/meal_model.dart';
import 'package:food_planner/features/meal/presentation/components/ingredient_widget.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/cached_images.dart';
import '../../../meal/presentation/components/rounded_container.dart';

class FavMealScreen extends StatefulWidget {
  const FavMealScreen({super.key, required this.meal});
  final Meal meal;
  @override
  State<FavMealScreen> createState() => _FavMealScreenState();
}

class _FavMealScreenState extends State<FavMealScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, List<Meal>>(
      listener: (context, state) {},
      builder: (context, state) {
        final favoritesCubit = context.read<FavoritesCubit>();
        final isFavorite = favoritesCubit.isFavorite(widget.meal.idMeal!);
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  actions: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      height: 35.h,
                      width: 35.w,
                      child: RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            if (isFavorite) {
                              favoritesCubit
                                  .removeMealFromFavorites(widget.meal);
                            } else {
                              favoritesCubit.addMealToFavorites(
                                  widget.meal, context);
                            }
                          });
                        },
                        child: SizedBox(
                            height: 25.h,
                            width: 25.w,
                            child: SvgPicture.asset(
                              isFavorite
                                  ? 'selectedHeart'.svgPath()
                                  : 'unSelectedHeart'.svgPath(),
                              color: ColorsManager.primary,
                            )),
                      ),
                    ),
                    horizontalSpace(20.w)
                  ],
                  pinned: true,
                  backgroundColor: ColorsManager.primary.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(60.r),
                          bottomLeft: Radius.circular(60.r))),
                  expandedHeight: 300.h,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedImageItem(
                      sliverAppBar: true,
                      width: double.infinity,
                      height: 300.h,
                      url: widget.meal.strMealThumb!,
                      radius: 60.r,
                      circleShape: false,
                    ),
                  )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20.h),
                      Text(
                        widget.meal.strMeal!,
                        style: TextStyles.font24Black700,
                      ),
                      verticalSpace(10.h),
                      Row(
                        children: [
                          RoundedContainer(
                            text: widget.meal.strCategory ?? 'Random Category',
                          ),
                          horizontalSpace(10.w),
                          RoundedContainer(
                            text: widget.meal.strArea ?? 'Random Area',
                          )
                        ],
                      ),
                      verticalSpace(20.h),
                      Text(
                        'Ingredients',
                        style: TextStyles.font20Black700
                            .copyWith(color: ColorsManager.primary),
                      ),
                      verticalSpace(10.h),
                      Wrap(
                        direction: Axis.horizontal,
                        children: List.generate(
                            widget.meal.ingredients!
                                .where((e) => e != '' && e != null)
                                .length,
                            (index) => IngredientWidget(
                                  ingredient:
                                      '${widget.meal.ingredients![index] ?? ''} - ${widget.meal.measures![index] ?? ''}',
                                )),
                      ),
                      verticalSpace(20.h),
                      Text(
                        'Steps',
                        style: TextStyles.font20Black700
                            .copyWith(color: ColorsManager.primary),
                      ),
                      verticalSpace(10.h),
                      Text(
                        widget.meal.strInstructions ?? 'No Instructions',
                        style: TextStyles.font14Black400,
                      ),
                      verticalSpace(40.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
