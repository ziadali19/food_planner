import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class IngredientWidget extends StatelessWidget {
  const IngredientWidget({
    super.key,
    required this.ingredient,
  });

  final String ingredient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 10.w, end: 10.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: ColorsManager.secondary),
        child: Text(
          ingredient,
          style: TextStyles.font14Black400,
        ),
      ),
    );
  }
}
