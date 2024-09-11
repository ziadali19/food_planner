import 'package:bloc/bloc.dart';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  PageController pageController = PageController();
  int pageIndex = 0;
  changePage(value) {
    pageIndex = value;
    emit(ChangeIndex());
  }

  List<String> onBoardImages = ['onboarding1', 'onboarding2', 'onboarding3'];
  List<String> onBoardTitles = [
    "Plan Your Meals Effortlessly",
    "Discover New Recipes",
    "Save Your Favorites",
  ];
  List<String> onBoardSubTitles = [
    "Organize your weekly meals in just a few taps. Save time and enjoy a healthier lifestyle.",
    "Explore meals from various cuisines around the world. Find inspiration for your next meal.",
    "Keep track of your favorite meals and access them anytime, even without an internet connection.",
  ];
}
