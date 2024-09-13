import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_planner/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

import 'core/helpers/bloc_observer.dart';
import 'core/services/service_locator.dart';
import 'core/services/shared_perferences.dart';
import 'core/utils/constants.dart';
import 'food_planner_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.systemLocale = await findSystemLocale();
  initializeDateFormatting(Intl.systemLocale);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ServiceLocator.init();
  await CacheHelper.instance.init();

  AppConstants.userToken = CacheHelper.instance.getData('userToken') as String?;

  AppConstants.name = CacheHelper.instance.getData('name') as String?;

  AppConstants.onBoarding = CacheHelper.instance.getData('onBoarding') as bool?;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();
  runApp(const FoodPlannerApp());
}
