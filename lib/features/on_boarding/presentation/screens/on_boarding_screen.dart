import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../controller/cubit/onboarding_cubit.dart';
import '../components/onboarding_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return SafeArea(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  context.read<OnboardingCubit>().changePage(value);
                },
                controller: context.read<OnboardingCubit>().pageController,
                itemCount: context.read<OnboardingCubit>().onBoardImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        top: 200.h,
                        child: Image.asset(
                          'assets/images/${context.read<OnboardingCubit>().onBoardImages[index]}.png', // Your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0.h,
                        left: 0,
                        right: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(150.r)),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            color: ColorsManager.secondary,
                            height: 400.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  context
                                      .read<OnboardingCubit>()
                                      .onBoardTitles[index],
                                  style: TextStyle(
                                    fontSize: 23.sp,
                                    color: ColorsManager.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                verticalSpace(16.h),
                                Text(
                                  context
                                      .read<OnboardingCubit>()
                                      .onBoardSubTitles[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      index != 2
                          ? Positioned(
                              bottom: 50.h,
                              child: Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex:
                                      context.read<OnboardingCubit>().pageIndex,
                                  count: context
                                      .read<OnboardingCubit>()
                                      .onBoardImages
                                      .length,
                                  effect: WormEffect(
                                      dotHeight: 16.h,
                                      dotWidth: 16.w,
                                      dotColor: Colors.white54,
                                      activeDotColor: const Color.fromARGB(
                                          255, 54, 141, 137)),
                                ),
                              ),
                            )
                          : Positioned(
                              bottom: 50.h,
                              child: const Center(child: OnBoardingButton()),
                            ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
