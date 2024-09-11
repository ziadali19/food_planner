import 'package:flutter/material.dart';

class AppConstants {
  static String? userToken;
  static String? userId;
  static bool? onBoarding;
  static String? name;
  static String? userType;
  static final navKey = GlobalKey<NavigatorState>();

  static const baseURL = 'www.themealdb.com/api/json/v1/1/';
}
