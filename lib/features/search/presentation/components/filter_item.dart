import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.onTap,
    required this.containerBgColor,
    required this.containerTextColor,
    required this.name,
  });
  final void Function()? onTap;
  final Color? containerBgColor;
  final Color? containerTextColor;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsetsDirectional.only(end: 10.w, bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
            border: Border.all(color: ColorsManager.primary),
            color: containerBgColor,
            borderRadius: BorderRadius.circular(4.r)),
        child: Text(name!,
            style:
                TextStyles.font16Black400.copyWith(color: containerTextColor)),
      ),
    );
  }
}
