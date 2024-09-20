import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_planner/core/helpers/extensions.dart';
import 'package:food_planner/core/helpers/show_toast.dart';
import 'package:food_planner/core/services/service_locator.dart';
import 'package:food_planner/core/services/shared_perferences.dart';
import 'package:food_planner/core/widgets/custom_elevated_button.dart';
import 'package:food_planner/features/settings/controller/cubit/settings_cubit.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/loading_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Account')),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    sl<FirebaseAuth>().currentUser?.email ?? 'Guest user',
                    overflow: TextOverflow.ellipsis, // Handle long names
                    style: TextStyles.font18Black500,
                  ),
                  const Spacer(),
                  BlocConsumer<SettingsCubit, SettingsState>(
                    listener: (context, state) {
                      if (state is SettingsLoggedOut) {
                        context.pop();
                        CacheHelper.instance
                            .removeData('userToken')
                            .then((value) {
                          AppConstants.userToken = null;
                          CacheHelper.instance.removeData('name').then((value) {
                            AppConstants.name = null;
                            context.pushReplacementNamed(Routes.login);
                          });
                        });
                      }
                      if (state is SettingsError) {
                        context.pop();
                        showSnackBar(state.message, context, false);
                      }
                      if (state is SettingsLoading) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return const LoadingDialog();
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomElevatedButton(
                          buttonText: AppConstants.isGuest ? 'Login' : 'Logout',
                          onPressed: () {
                            if (AppConstants.isGuest) {
                              context.pushReplacementNamed(Routes.login);
                            } else {
                              context.read<SettingsCubit>().logout(context);
                            }
                          });
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
