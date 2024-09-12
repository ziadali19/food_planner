import 'package:flutter/material.dart';
import 'package:food_planner/core/routing/routes.dart';
import 'package:food_planner/features/auth/presentation/screens/login_screen.dart';

import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/landing/presentation/screens/landing_screen.dart';

class AppRouter {
  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    Object? arguments = settings.arguments;
    switch (settings.name) {
      case Routes.landing:
        return MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
