import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class CountryWidget extends StatelessWidget {
  const CountryWidget({
    super.key,
    required this.country,
  });

  final String country;

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
          country,
          style:
              TextStyles.font16Black500.copyWith(color: ColorsManager.primary),
        ),
      ),
    );
  }
}
