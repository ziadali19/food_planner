import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_planner/core/helpers/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/services/shared_perferences.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
        buttonWidth: 200.w,
        buttonText: 'Get Started',
        onPressed: () {
          CacheHelper.instance.saveData('onBoarding', true).then((value) {
            AppConstants.onBoarding = true;
            context.pushReplacementNamed(Routes.login);
          });
        });
  }
}
