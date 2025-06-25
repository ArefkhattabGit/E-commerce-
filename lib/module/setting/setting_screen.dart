import 'package:final_poject_sw_engineering/app/app_colors.dart';
import 'package:final_poject_sw_engineering/module/complaint/complaint_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/app_config.dart';
import '../../app/app_constatns.dart';
import '../../routes/app_routes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
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
      body: ListView(
        children: [
          const SizedBox(height: 16),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.snackbar("Coming soon", "Language change will be added later");
            },
          ),

          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.snackbar("Coming soon", "Change password screen");
            },
          ),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About the App'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.dialog(

                AlertDialog(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  title: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blueAccent, size: 24.sp),
                      SizedBox(width: 8.w),
                      Text(
                        "About",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  content: Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Version: 1.0.0",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "This app is built for managing users, products, and categories in an efficient and responsive way using Flutter and GetX.",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                  actionsPadding: EdgeInsets.only(right: 12.w, bottom: 10.h),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "Close",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              );

            },
          ),


          ListTile(
            leading: const Icon(Icons.report_problem_outlined),
            title: const Text('Complaint'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {

            Get.dialog(
              AlertDialog(
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                title: Row(
                  children: [
                    Icon(Icons.feedback_outlined, color: Colors.blueAccent, size: 24.sp),
                    SizedBox(width: 8.w),
                    Text(
                      "Submit Complaint",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                content: Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Please describe the issue you’re facing. We’ll do our best to resolve it.",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      SizedBox(height: 12.h),
                      TextField(
                        controller: Get.find<ComplaintController>().descriptionController,
                        maxLines: 4,
                        minLines: 3,
                        decoration: InputDecoration(
                          hintText: "Write your complaint here...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          contentPadding: EdgeInsets.all(12.r),
                        ),
                      ),
                    ],
                  ),
                ),
                actionsPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      String complaint =  Get.find<ComplaintController>().descriptionController.text;
                      if (complaint.isNotEmpty) {

                        Get.find<ComplaintController>().postUserComplaint();



                      } else {
                        Get.snackbar("Error", "Please write something before sending.",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    icon: Icon(Icons.send, color: Colors.white),
                    label: Text(
                      "Send",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ],
              ),
              barrierDismissible: false,
            );

            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  title: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.orangeAccent, size: 24.sp),
                      SizedBox(width: 8.w),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  content: Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      "Are you sure you want to logout?",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  actionsPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        AppConfig.remove(AppConstants.USER_TOKEN);
                        AppConfig.remove(AppConstants.USER_ROLE);
                        Get.offAndToNamed(AppRoutes.loginScreen);
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text("Logout", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ],
                ),
                barrierDismissible: false,
              );

            },
          ),

          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text(
              'Delete Account',
              style: TextStyle(color: Colors.red),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  title: Row(
                    children: [
                      Icon(Icons.delete_forever, color: Colors.red, size: 24.sp),
                      SizedBox(width: 8.w),
                      Text(
                        "Delete Account",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  content: Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      "This action is irreversible. Are you sure you want to delete your account?",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  actionsPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.back(); // Optional: Close the dialog first
                        Get.offAllNamed('/login');
                        Get.snackbar("Account Deleted", "Your account has been deleted.",
                            backgroundColor: Colors.red, colorText: Colors.white);
                      },
                      icon: Icon(Icons.delete_forever, color: Colors.white),
                      label: Text("Delete", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ],
                ),
                barrierDismissible: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
