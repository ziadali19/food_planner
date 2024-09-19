import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_planner/core/helpers/extensions.dart';

import '../../../../core/theming/colors.dart';

BottomNavigationBarItem navBarItem(
  String svg,
) {
  return BottomNavigationBarItem(
      activeIcon: Column(
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: SvgPicture.asset(
              svg.svgPath(),
              color: ColorsManager.primary,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: 5.w,
            height: 5.h,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorsManager.primary),
          )
        ],
      ),
      icon: SvgPicture.asset(
        svg.svgPath(),
      ),
      label: '');
}
