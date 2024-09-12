import 'package:flutter/material.dart';
import 'package:food_planner/core/helpers/extensions.dart';
// ignore: unused_import
import 'package:food_planner/features/auth/presentation/screens/login_screen.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class DontHaveAccontText extends StatelessWidget {
  const DontHaveAccontText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          children: [
            const TextSpan(text: ' '),
            WidgetSpan(
                style: TextStyles.font14Primary700.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: ColorsManager.primary.withOpacity(0.5)),
                child: InkWell(
                    onTap: () {
                      context.pushNamed(Routes.register);
                    },
                    child: Text(
                      "Register",
                      style: TextStyles.font14Primary700.copyWith(
                        color: ColorsManager.primary.withOpacity(0.5),
                      ),
                    )))
          ],
          text: 'Don\'t have an account?',
          style: TextStyles.font14Black500.copyWith(
            color: Colors.black.withOpacity(0.5),
            fontFamily: 'IBMPlexSans',
          )),
    );
  }
}
