import 'package:final_poject_sw_engineering/module/adminDashboard/adminDashboardProducts/show_admin_dashboard_poducts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_dimensions.dart';
import '../../../helper/font_helper.dart';

class ShowAdminDashboardProductsScreen extends StatelessWidget {
  const ShowAdminDashboardProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShowAdminDashboardProductsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: FontHelper.cairoBold700(
            fontSize: 20.sp,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<ShowAdminDashboardProductsController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = controller.tHome?.data?.data.products ?? [];

          if (products.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                  'No products found.',
                  style: FontHelper.cairoMedium500(fontSize: 16.sp),
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: products.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final product = products[index];

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          product.image ?? '',
                          width: 80.w,
                          height: 80.h,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 80.w,
                            height: 80.h,
                            color: Colors.grey.withOpacity(0.1),
                            child: Icon(Icons.image_not_supported, color: Colors.grey, size: 32.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? 'Unnamed',
                              style: FontHelper.cairoBold700(
                                fontSize: 16.sp,
                                color: AppColors.blackColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '\$${product.finalPrice ?? '0.00'}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              product.description ?? 'No description.',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade700,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Menu
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, size: 22.sp),
                        onSelected: (value) {
                          if (value == 'update') {
                            // TODO: Implement update logic
                          } else if (value == 'delete') {
                            _confirmDelete(controller, product.id);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'update',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 18.sp, color: Colors.blue),
                                SizedBox(width: 8.w),
                                Text('Update'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 18.sp, color: Colors.red),
                                SizedBox(width: 8.w),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(ShowAdminDashboardProductsController controller, int productId) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 26.sp),
            SizedBox(width: 8.w),
            Text("Delete Product", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Text(
            "Are you sure you want to delete this product? This action cannot be undone.",
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              controller.deleteProductsAdminDashBoard(productId);
              Get.back();
            },
            icon: Icon(Icons.delete, color: Colors.white, size: 18.sp),
            label: Text("Delete", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            ),
          ),
        ],
      ),
    );
  }
}
