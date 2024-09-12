import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  const CustomElevatedButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: -5,
          blurRadius: 4,
          offset: Offset(0.w, 4.h),
        )
      ]),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          overlayColor:
              const WidgetStatePropertyAll(Color.fromARGB(255, 137, 187, 184)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? ColorsManager.primary,
          ),
          padding: WidgetStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 18.w,
              vertical: verticalPadding ?? 8.h,
            ),
          ),
          fixedSize: WidgetStateProperty.all(
            Size(buttonWidth ?? double.maxFinite, buttonHeight ?? 50.h),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: textStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
