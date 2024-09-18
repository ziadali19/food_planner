import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_planner/features/search/presentation/screens/search_screen.dart';
import 'package:meta/meta.dart';

import '../../../landing/presentation/screens/landing_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  int selectedIndex = 0;
  List<Widget> navScreens = [
    const LandingScreen(),
    const SearchScreen(),
    Container(),
  ];
  List<String> navIcons = ['home', 'search', 'unSelectedHeart'];
  changeNavScreen(int index) {
    selectedIndex = index;
    emit(ChangeIndex());
  }
}
