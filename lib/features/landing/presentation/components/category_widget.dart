import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/cached_images.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.categoryName,
    required this.categoryThumb,
  });

  final String categoryName;
  final String categoryThumb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 20.w),
      child: Column(
        children: [
          CachedImageItem(
              circleShape: true,
              width: 60.w,
              height: 60.h,
              url: categoryThumb,
              radius: 100.r),
          verticalSpace(10.h),
          Text(
            categoryName,
            style: TextStyles.font16Black500,
          )
        ],
      ),
    );
  }
}
