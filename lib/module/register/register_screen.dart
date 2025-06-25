import 'package:final_poject_sw_engineering/module/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/app_colors.dart';
import '../../app/app_dimensions.dart';
import '../../helper/custom_text_field_helper.dart';
import '../../helper/font_helper.dart';
import '../../routes/app_routes.dart';
import '../../widget/custom_outline_button_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find<RegisterController>();

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
                  'Create a New Account',
                  style: FontHelper.cairoBold700(
                    fontSize: 24.sp,
                    color: AppColors.blackColor08,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Enter your details to create a new account',
                  style: FontHelper.cairoRegular400(
                    fontSize: 16.sp,
                    color: AppColors.greyColor292D32,
                  ),
                ),
                SizedBox(height: 30.h),
                CustomTextFieldHelper(
                  controller: controller.nameController,
                  hintText: 'Name',
                  validationType: InputValidationType.name,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20.h),
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
                  textInputAction: TextInputAction.next,
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
                SizedBox(height: 20.h),
                Obx(() => CustomTextFieldHelper(
                  controller: controller.confirmPasswordController,
                  hintText: 'Confirm Password',
                  validationType: InputValidationType.password,
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfirmPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.greyColor292D32,
                    ),
                    onPressed: controller.toggleConfirmPasswordVisibility,
                  ),
                  validator: (value) {
                    if (value != controller.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                )),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: controller.register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    minimumSize: Size(double.infinity, 58.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.rCornerSmall_8),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: FontHelper.cairoMedium500(
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                CustomOutlineButtonWidget(
                  onPressed: () {
                    Get.offAndToNamed(AppRoutes.loginScreen);
                  },
                  prefixText: 'Already have an account?',
                  suffixText: 'Login',
                  prfxColorText: AppColors.blackColor08,
                  showSuffixIcon: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
