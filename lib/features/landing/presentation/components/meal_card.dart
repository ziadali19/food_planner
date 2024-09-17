import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_planner/core/helpers/extensions.dart';

import 'package:food_planner/core/theming/colors.dart';
import 'package:food_planner/core/theming/styles.dart';

import '../../../../core/widgets/cached_images.dart';

class MealCard extends StatelessWidget {
  const MealCard(
      {super.key,
      required this.title,
      required this.image,
      required this.country});
  final String title;
  final String image;
  final String country;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: ColorsManager.secondary),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  CachedImageItem(
                      width: 150.w, height: 115.h, url: image, radius: 100.r),
                  Text(
                    title,
                    style: TextStyles.font18Black500,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    country,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font16Black500
                        .copyWith(color: ColorsManager.primary),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              transform: Matrix4.translationValues(0, 10.h, 0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              height: 55.h,
              width: 55.w,
              child: RawMaterialButton(
                onPressed: () {},
                child: SizedBox(
                    height: 35.h,
                    width: 35.w,
                    child: SvgPicture.asset('unSelectedHeart'.svgPath())),
              ),
            ),
          )
        ],
      ),
    );
  }
}
/*
Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Image
                CachedImageItem(
                    width: 143.w, height: 125.h, url: image, radius: 12.r),
                SizedBox(width: 10.w),

                // Food Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Favorite Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyles.font16Black500,
                          ),
                          const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ],
                      ),

                      // Description
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),

                      // Timing, Rating, and Price
                    ],
                  ),
                ),
              ],
            ),
          ),
        

*/ 