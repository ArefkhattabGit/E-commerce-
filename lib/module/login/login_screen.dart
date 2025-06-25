import 'package:final_poject_sw_engineering/app/app_colors.dart';
import 'package:final_poject_sw_engineering/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/app_config.dart';
import '../../app/app_constatns.dart';
import '../../app/app_dimensions.dart';
import '../../helper/custom_text_field_helper.dart';
import '../../helper/font_helper.dart';
import '../../widget/custom_outline_button_widget.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: FontHelper.cairoBold700(
                    fontSize: 24.sp,
                    color: AppColors.blackColor08,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Fill Your Information to Access Your Account',
                  style: FontHelper.cairoRegular400(
                    fontSize: 16.sp,
                    color: AppColors.greyColor292D32,
                  ),
                ),
                SizedBox(height: 30.h),
                CustomTextFieldHelper(
                  controller: controller.emailController,
                  hintText: 'Email',
                  validationType: InputValidationType.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20.h),
                Obx(() => CustomTextFieldHelper(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      validationType: InputValidationType.password,
                      obscureText: !controller.isPasswordVisible.value,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.greyColor292D32,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    )),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    minimumSize: Size(double.infinity, 58.h),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.rCornerSmall_8),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: FontHelper.cairoMedium500(
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                CustomOutlineButtonWidget(
                  onPressed: () {
                    Get.offAndToNamed(AppRoutes.registerScreen);
                  },
                  prefixText: 'Dont have an account?',
                  suffixText: 'create an account',
                  prfxColorText: AppColors.blackColor08,
                  showSuffixIcon: true,
                ),

                SizedBox(height: 20.h),

                ElevatedButton(
                  onPressed: ()async {
                    await AppConfig.setBool(AppConstants.IS_GUEST,true);

                    Get.toNamed(AppRoutes.bottomNavScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    minimumSize: Size(double.infinity, 58.h),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(AppDimensions.rCornerSmall_8),
                    ),
                  ),
                  child: Text(
                    'Guest User',
                    style: FontHelper.cairoMedium500(
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
