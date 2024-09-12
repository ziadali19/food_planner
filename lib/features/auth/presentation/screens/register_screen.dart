import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_planner/core/helpers/extensions.dart';
import 'package:food_planner/features/auth/controller/cubit/register_cubit.dart';

import '../../../../core/helpers/remove_focus.dart';
import '../../../../core/helpers/show_toast.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/auth_text_field.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/loading_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: 'register');
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('REGISTER')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Welcome',
                  style: TextStyles.font24Black700,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Let\'s get started',
                  style: TextStyles.font12Grey500,
                ),
              ),
              verticalSpace(20.h),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is UserRegisterLoading) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return const LoadingDialog();
                      },
                    );
                  }
                  if (state is UserRegisterSuccess) {
                    context.pop();
                    context.pop();
                    showSnackBar('Registered Successfully', context, true);
                  }

                  if (state is UserRegisterError) {
                    context.pop();

                    showSnackBar(state.errorMsg, context, false);
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyles.font12Black600,
                            ),
                            verticalSpace(14.h),
                            AuthTextFormField(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorsManager
                                      .primary, //BorderSide(width: 1, color: Color(0xFF79747E))
                                  width: 1.5.w,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .grey, //BorderSide(width: 1, color: Color(0xFF79747E))
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              maxLines: 1,
                              controller: emailController,
                              prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 10.w),
                                child: SvgPicture.asset(
                                  'email'.svgPath(),
                                  color: ColorsManager.primary,
                                ),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    !value.contains('@') ||
                                    !value.contains('.')) {
                                  return 'Enter a valid email';
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'Enter your email',
                            ),
                            verticalSpace(16.h),
                            Text(
                              'Password',
                              style: TextStyles.font12Black600,
                            ),
                            verticalSpace(14.h),
                            AuthTextFormField(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorsManager
                                      .primary, //BorderSide(width: 1, color: Color(0xFF79747E))
                                  width: 1.5.w,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .grey, //BorderSide(width: 1, color: Color(0xFF79747E))
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              maxLines: 1,
                              controller: passwordController,
                              isObscureText:
                                  context.read<RegisterCubit>().isVisible
                                      ? false
                                      : true,
                              suffixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(end: 10.w),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<RegisterCubit>()
                                        .toggleVisibility();
                                  },
                                  child: context.read<RegisterCubit>().isVisible
                                      ? SvgPicture.asset(
                                          'assets/svgs/openedEye.svg',
                                          color: ColorsManager.primary,
                                        )
                                      : SvgPicture.asset(
                                          'assets/svgs/closedEye.svg',
                                          color: ColorsManager.primary,
                                        ),
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 10.w),
                                child: SvgPicture.asset(
                                  'lock'.svgPath(),
                                  color: ColorsManager.primary,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'Enter your password',
                            ),
                            verticalSpace(16.h),
                            Text(
                              'Password Confirmation',
                              style: TextStyles.font12Black600,
                            ),
                            verticalSpace(14.h),
                            AuthTextFormField(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorsManager
                                      .primary, //BorderSide(width: 1, color: Color(0xFF79747E))
                                  width: 1.5.w,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .grey, //BorderSide(width: 1, color: Color(0xFF79747E))
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              maxLines: 1,
                              controller: passwordConfirmationController,
                              isObscureText:
                                  context.read<RegisterCubit>().isVisible
                                      ? false
                                      : true,
                              suffixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(end: 10.w),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<RegisterCubit>()
                                        .toggleVisibility();
                                  },
                                  child: context.read<RegisterCubit>().isVisible
                                      ? SvgPicture.asset(
                                          'assets/svgs/openedEye.svg',
                                          color: ColorsManager.primary,
                                        )
                                      : SvgPicture.asset(
                                          'assets/svgs/closedEye.svg',
                                          color: ColorsManager.primary,
                                        ),
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 10.w),
                                child: SvgPicture.asset(
                                  'lock'.svgPath(),
                                  color: ColorsManager.primary,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                } else if (passwordConfirmationController
                                        .text !=
                                    passwordController.text) {
                                  return 'Passwords do not match';
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'Enter your password',
                            ),
                            verticalSpace(40.h),
                            CustomElevatedButton(
                                buttonText: 'REGITSER',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    removeFocus(context);
                                    context
                                        .read<RegisterCubit>()
                                        .signUpWithEmail(
                                            emailController.text.trim(),
                                            passwordController.text.trim());
                                  }
                                }),
                          ],
                        )),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
