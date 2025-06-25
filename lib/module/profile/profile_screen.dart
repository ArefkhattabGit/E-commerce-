import 'package:final_poject_sw_engineering/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../helper/font_helper.dart';
import '../../helper/custom_text_field_helper.dart';
import '../../app/app_dimensions.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.cyanAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: GetBuilder<ProfileController>(builder: (controller) {
        final profile = controller.tProfile;
        return controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: AppColors.mainColor.withOpacity(0.8),
                  child: Text(
                    _getInitials(profile?.data?.name ?? ''),
                    style: FontHelper.cairoBold700(
                      fontSize: 24.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                _buildReadOnlyText(profile!.data!.name ),

                SizedBox(height: 12.h),
                CustomTextFieldHelper(
                  controller: controller.emailController,
                  hintText: 'Email',
                  enabled: false,
                  validationType: InputValidationType.email,
                ),

                SizedBox(height: 20.h),

                CustomTextFieldHelper(
                  controller: controller.areaController,
                  hintText: 'Area',
                  validationType: InputValidationType.location,
                ),
                SizedBox(height: 12.h),

                // Editable: Street
                CustomTextFieldHelper(
                  controller: controller.streetController,
                  hintText: 'Street',
                ),
                SizedBox(height: 12.h),

                CustomTextFieldHelper(
                  controller: controller.buildingController,
                  hintText: 'Building',
                  validationType: InputValidationType.location,
                ),
                SizedBox(height: 30.h),

                ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.saveUserProfile();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    minimumSize: Size(double.infinity, 52.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.rCornerSmall_8),
                    ),
                  ),
                  child: Text(
                    'Save Profile',
                    style: FontHelper.cairoMedium500(
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildReadOnlyText(String name) {
    return Text(
      name,
      style: FontHelper.cairoBold700(
        fontSize: 20.sp,
        color: AppColors.blackColor08,
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return parts[0][0] + parts[1][0];
    } else if (parts.isNotEmpty) {
      return parts[0];
    }
    return '';
  }
}
