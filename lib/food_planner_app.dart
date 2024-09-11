import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';

import 'core/theming/themes.dart';
import 'core/utils/constants.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/landing/presentation/screens/landing_screen.dart';
import 'features/on_boarding/presentation/screens/on_boarding_screen.dart';

class WorkFlowApp extends StatelessWidget {
  const WorkFlowApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 843.4285714285714),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: AppConstants.navKey,
          home: AppConstants.onBoarding != true
              ? const OnBoardingScreen()
              : AppConstants.userToken != null
                  ? const LandingScreen()
                  : const LoginScreen(),
          onGenerateRoute: (settings) {
            return AppRouter.onGenerateRoute(settings);
          },
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);

            return MediaQuery(
              data: mediaQueryData.copyWith(
                  textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          theme: Themes.instance.lightTheme(context),
        );
      },
    );
  }
}
