// ShowCategoryScreen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../app/app_colors.dart';
import '../../helper/font_helper.dart';
import 'show_category_controller.dart';

class ShowCategoryScreen extends StatelessWidget {
  const ShowCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShowCategoryController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: FontHelper.cairoBold700(
            fontSize: 20.sp,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<ShowCategoryController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final categories = controller.tCategory?.data?.data;

          if (categories == null || categories.categories.isEmpty) {
            return const Center(child: Text('No categories found.'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  "Category Count : ${categories.categories.length}",
                  style: FontHelper.cairoMedium500(fontSize: 16.sp),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: categories.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final category = categories.categories[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            category.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                          ),
                        ),
                        title: Text(
                          category.name,
                          style: FontHelper.cairoMedium500(fontSize: 16.sp),
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'update') {
                              controller.nameController.text = category.name;
                              controller.updatedImage.value = null;
                              _showUpdateDialog(controller, category.id, category.image);
                            } else if (value == 'delete') {
                              _confirmDelete(controller, category.id);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'update',
                              child: Text('Update'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmDelete(ShowCategoryController controller, int categoryId) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red, size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              "Delete Category",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Text(
            "Are you sure you want to delete this category? This action cannot be undone.",
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel", style: TextStyle(fontSize: 14.sp)),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await controller.deleteAdminCategory(categoryId);
              Get.back();
            },
            icon: const Icon(Icons.delete, color: Colors.white),
            label: const Text("Delete", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            ),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(ShowCategoryController controller, int categoryId, String currentImageUrl) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: const Text("Update Category"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: "Category Name"),
              ),
              SizedBox(height: 12.h),
              Obx(() {
                return Container(
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: controller.updatedImage.value != null
                          ? FileImage(controller.updatedImage.value!) as ImageProvider
                          : NetworkImage(currentImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
              SizedBox(height: 10.h),
              ElevatedButton.icon(
                onPressed: () async {
                  final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    controller.updatedImage.value = File(picked.path);
                  }
                },
                icon: const Icon(Icons.image, color: AppColors.white),
                label: const Text("Select New Image", style: TextStyle(color: AppColors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  minimumSize: Size(double.infinity, 45.h),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
               Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor),
            child: const Text("Update", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}