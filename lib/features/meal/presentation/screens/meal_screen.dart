import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_planner/core/helpers/extensions.dart';
import 'package:food_planner/core/helpers/show_toast.dart';
import 'package:food_planner/core/helpers/spacing.dart';
import 'package:food_planner/features/favorite/controller/cubit/favorites_cubit.dart';
import 'package:food_planner/features/meal/presentation/components/ingredient_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/cached_images.dart';

import '../../controller/cubit/meal_cubit.dart';
import '../components/rounded_container.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key, required this.mealId});
  final String mealId;
  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          'https://www.youtube.com/watch?v=AYXfaVD5o40')!);

  @override
  void initState() {
    context.read<MealCubit>().getMealById(widget.mealId);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {
        if (state is GetMealByIdError) {
          showSnackBar(state.errorMsg, context, false);
        }
        if (state is GetMealByIdSuccess) {
          if (context.read<MealCubit>().meal!.strYoutube != null &&
              context.read<MealCubit>().meal!.strYoutube!.isNotEmpty) {
            _controller = YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(
                  context.read<MealCubit>().meal!.strYoutube ?? '')!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        MealCubit cubit = context.read<MealCubit>();
        if (state is GetMealByIdLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is GetMealByIdSuccess) {
          final favoritesCubit = context.read<FavoritesCubit>();
          final isFavorite = favoritesCubit.isFavorite(cubit.meal!.idMeal!);
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
                                    .removeMealFromFavorites(cubit.meal!);
                              } else {
                                favoritesCubit.addMealToFavorites(
                                    cubit.meal!, context);
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
                        url: cubit.meal!.strMealThumb!,
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
                          cubit.meal!.strMeal!,
                          style: TextStyles.font24Black700,
                        ),
                        verticalSpace(10.h),
                        Row(
                          children: [
                            RoundedContainer(
                              text:
                                  cubit.meal!.strCategory ?? 'Random Category',
                            ),
                            horizontalSpace(10.w),
                            RoundedContainer(
                              text: cubit.meal!.strArea ?? 'Random Area',
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
                              cubit.meal!.ingredients!
                                  .where((e) => e != '' && e != null)
                                  .length,
                              (index) => IngredientWidget(
                                    ingredient:
                                        '${cubit.meal!.ingredients![index] ?? ''} - ${cubit.meal!.measures![index] ?? ''}',
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
                          cubit.meal!.strInstructions ?? 'No Instructions',
                          style: TextStyles.font14Black400,
                        ),
                        verticalSpace(20.h),
                        if (context.read<MealCubit>().meal!.strYoutube !=
                                null &&
                            context
                                .read<MealCubit>()
                                .meal!
                                .strYoutube!
                                .isNotEmpty)
                          Text(
                            'Video',
                            style: TextStyles.font20Black700
                                .copyWith(color: ColorsManager.primary),
                          ),
                        verticalSpace(10.h),
                        if (context.read<MealCubit>().meal!.strYoutube !=
                                null &&
                            context
                                .read<MealCubit>()
                                .meal!
                                .strYoutube!
                                .isNotEmpty)
                          YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.red,
                            onReady: () {},
                          ),
                        verticalSpace(40.h),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        if (state is GetMealByIdError) {
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
