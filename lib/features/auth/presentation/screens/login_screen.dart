import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_planner/core/helpers/extensions.dart';

import '../../../../core/helpers/remove_focus.dart';
import '../../../../core/helpers/show_toast.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/auth_text_field.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/loading_dialog.dart';
import '../../controller/cubit/login_cubit.dart';
import '../components/dont_have_accont_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: 'login');
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                )),
                child: Image.asset(
                  'assets/images/loginImg.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300.h,
                ),
              ),
              verticalSpace(10.h),
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
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is UserLoginLoading) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return const LoadingDialog();
                      },
                    );
                  }
                  /*  if (state is UserLoginSuccess) {
                context.pop();
                CacheHelper.instance
                    .saveData('userToken', state.loginResponse.token)
                    .then((value) {
                  AppConstants.userToken = state.loginResponse.token;
                  context
                      .read<LoginCubit>()
                      .sendFcmToken(Notifications.fcmToken!);
                  CacheHelper.instance
                      .saveData(
                          'userId', state.loginResponse.data!.userId!)
                      .then((value) {
                    AppConstants.userId =
                        state.loginResponse.data!.userId!;
                    CacheHelper.instance
                        .saveData('name', state.loginResponse.data!.name)
                        .then((value) {
                      AppConstants.name = state.loginResponse.data!.name!;
                      CacheHelper.instance
                          .saveData(
                              'userType', state.loginResponse.data!.type)
                          .then((value) {
                        AppConstants.userType =
                            state.loginResponse.data!.type;
                        context.pushReplacementNamed(Routes.landing);
                    
                        showSnackBar(
                            state.loginResponse.message, context, true);
                      });
                    });
                  });
                });
              }*/

                  if (state is UserLoginError) {
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
                                  context.read<LoginCubit>().isVisible
                                      ? false
                                      : true,
                              suffixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(end: 10.w),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<LoginCubit>()
                                        .toggleVisibility();
                                  },
                                  child: context.read<LoginCubit>().isVisible
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
                            verticalSpace(40.h),
                            CustomElevatedButton(
                                buttonText: 'SIGN IN',
                                textStyle: TextStyles.font16White500,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    removeFocus(context);
                                    /* context.read<LoginCubit>().userLogin(
                                    emailController.text.trim(),
                                    passwordController.text.trim());*/
                                  }
                                }),
                            verticalSpace(20.h),
                            Center(
                              child: Text('Or continue with',
                                  style: TextStyles.font14Black500.copyWith(
                                    color: Colors.black.withOpacity(0.5),
                                  )),
                            ),
                            verticalSpace(10.h),
                            Center(
                                child: InkWell(
                              onTap: () {},
                              child: SizedBox(
                                  height: 30.h,
                                  width: 30.w,
                                  child: SvgPicture.asset('google'.svgPath())),
                            )),
                            verticalSpace(27.h),
                            const Center(child: DontHaveAccontText()),
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
