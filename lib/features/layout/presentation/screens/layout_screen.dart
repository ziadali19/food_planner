import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_planner/features/layout/controller/cubit/layout_cubit.dart';

import '../../../../core/theming/colors.dart';
import '../components/nav_bar_item.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LayoutCubit(),
        child: BlocBuilder<LayoutCubit, LayoutState>(
          builder: (context, state) {
            LayoutCubit cubit = context.read<LayoutCubit>();
            return Scaffold(
              bottomNavigationBar: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: BottomNavigationBar(
                    backgroundColor: ColorsManager.secondary,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    elevation: 0,
                    currentIndex: cubit.selectedIndex,
                    onTap: (value) {
                      cubit.changeNavScreen(value);
                    },
                    items: [
                      navBarItem('home'),
                      navBarItem('search'),
                      navBarItem('unSelectedHeart'),
                      navBarItem('setting')
                    ]),
              ),
              body: context
                  .read<LayoutCubit>()
                  .navScreens[context.read<LayoutCubit>().selectedIndex],
            );
          },
        ));
  }
}
