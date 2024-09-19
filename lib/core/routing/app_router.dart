import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_planner/core/routing/routes.dart';
import 'package:food_planner/features/auth/presentation/screens/login_screen.dart';
import 'package:food_planner/features/meal/controller/cubit/meal_cubit.dart';
import 'package:food_planner/features/meal/presentation/screens/meal_screen.dart';

import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/landing/presentation/screens/landing_screen.dart';
import '../services/service_locator.dart';

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
      case Routes.meal:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<MealCubit>(),
            child: MealScreen(mealId: arguments as String),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
