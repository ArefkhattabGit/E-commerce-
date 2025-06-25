import 'dart:io';
import 'package:final_poject_sw_engineering/module/adminCategory/show_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../app/app_colors.dart';
import '../../app/app_config.dart';
import '../../app/app_constatns.dart';
import '../../helper/font_helper.dart';
import '../../routes/app_routes.dart';
import 'adminDashboardProducts/show_admin_dashboard_products_screen.dart';
import 'admin_dashboard_controller.dart';

class AdminDashboardScreen extends StatelessWidget {
  AdminDashboardScreen({super.key});

  final controller = Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: FontHelper.cairoBold700(
            fontSize: 20.sp,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'add_category') {
                _showCategoryDialog();
              } else if (value == 'logout') {
                AppConfig.remove(AppConstants.USER_TOKEN);
                AppConfig.remove(AppConstants.USER_ROLE);
                Get.offAndToNamed(AppRoutes.loginScreen);
              } else if (value == 'show_category') {
                Get.to(() => ShowCategoryScreen());
              } else if (value == 'show_products') {
                Get.to(() => ShowAdminDashboardProductsScreen());
              }

            },
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'show_products',
                child: Text('Products'),
              ),
              const PopupMenuItem(
                value: 'show_category',
                child: Text('Category'),
              ),
              const PopupMenuItem(
                value: 'add_category',
                child: Text('Add Category'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: GetBuilder<AdminDashboardController>(
        builder: (controller) {
          return controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: controller.users!.data!.data.length,
                  itemBuilder: (context, index) {
                    final user = controller.users!.data!.data[index];
                    final isActive = user.status == 'active';

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name,
                                      style: FontHelper.cairoBold700(
                                        fontSize: 16.sp,
                                        color: AppColors.blackColor08,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      user.email,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      title: Row(
                                        children: [
                                          Icon(Icons.warning_amber_rounded,
                                              color: Colors.red, size: 24.sp),
                                          SizedBox(width: 8.w),
                                          Text(
                                            "Delete User",
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
                                          "Are you sure you want to delete this user? This action cannot be undone.",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                      actionsPadding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 10.h),
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
                                            controller.deleteUser(user.id);
                                            Get.back();
                                          },
                                          icon: const Icon(Icons.delete,
                                              color: Colors.white),
                                          label: const Text("Delete",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
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
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: -8,
                            children: (user.roles.isNotEmpty
                                    ? user.roles
                                        .map((role) => role.name)
                                        .toList()
                                    : ['Customer'])
                                .map(
                                  (roleName) => Chip(
                                    backgroundColor: isActive
                                        ? Colors.green.withOpacity(0.15)
                                        : Colors.red.withOpacity(0.15),
                                    label: Text(
                                      roleName,
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? Colors.green.withOpacity(0.15)
                                      : Colors.red.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isActive ? 'Active' : 'Inactive',
                                  style: TextStyle(
                                    color: isActive ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Switch(
                                value: isActive,
                                onChanged: (_) =>
                                    controller.toggleUserStatus(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  void _showCategoryDialog() {
    controller.categoryNameController.clear();
    controller.selectedImage.value = null;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          "Add Category",
          style: FontHelper.cairoBold700(fontSize: 18.sp),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller.categoryNameController,
                decoration: InputDecoration(
                  labelText: "Category Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Fixed Image Container (consistent size & style)
              Obx(() => Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.r),
                      image: controller.selectedImage.value != null
                          ? DecorationImage(
                              image: FileImage(controller.selectedImage.value!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: controller.selectedImage.value == null
                        ? const Center(child: Text("No image selected"))
                        : null,
                  )),
              SizedBox(height: 12.h),

              ElevatedButton.icon(
                onPressed: () async {
                  final picked = await controller.picker
                      .pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    controller.selectedImage.value = File(picked.path);
                  }
                },
                icon: const Icon(Icons.image, color: AppColors.white),
                label: const Text("Select Image",
                    style: TextStyle(color: AppColors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  minimumSize: Size(double.infinity, 45.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final name = controller.categoryNameController.text.trim();
              final image = controller.selectedImage.value;

              if (name.isEmpty || image == null) {
                Get.snackbar(
                    "Error", "Please enter a name and select an image");
                return;
              }

              controller.addCategory();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: const Text("Add", style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
