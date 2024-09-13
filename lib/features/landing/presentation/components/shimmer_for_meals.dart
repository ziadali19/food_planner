import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';

class ShimmerItemForMeals extends StatelessWidget {
  const ShimmerItemForMeals({
    super.key,
    required this.itemCount,
  });
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorsManager.secondary,
        highlightColor: Colors.white,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: itemCount,
          separatorBuilder: (context, index) {
            return verticalSpace(20.h);
          },
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundColor: ColorsManager.secondary,
                    ),
                    horizontalSpace(10.w),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r)),
                            height: 20.h,
                            width: 200.w,
                          ),
                          verticalSpace(10.h),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r)),
                            height: 20.h,
                            width: 200.w,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ));
  }
}
