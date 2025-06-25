import 'package:final_poject_sw_engineering/module/mainSellerTabs/displaySellerProducts/display_seller_products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/app_colors.dart';
import '../../../helper/font_helper.dart';

class DisplaySellerProducts extends StatelessWidget {
  final controller = Get.put(DisplaySellerProductsController());

  DisplaySellerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getSellerProductsPublished();
    return GetBuilder<DisplaySellerProductsController>(
      builder: (controller) => controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.tProductsSellers!.data!.data.products.isEmpty
          ? Padding(
        padding: EdgeInsets.all(20.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.storefront, size: 60, color: AppColors.mainColor),
              SizedBox(height: 20.h),
              Text(
                'My Products',
                style: FontHelper.cairoMedium500(
                  fontSize: 18.sp,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your products will appear here once added.',
                style: FontHelper.cairoRegular400(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      )
          : ListView.separated(
        padding: EdgeInsets.all(12.w),
        itemCount: controller.tProductsSellers!.data!.data.products.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final product = controller.tProductsSellers!.data!.data.products[index];
          return GestureDetector(
            onTap: () {
              print(product.id);
            },
            child: Card(
              elevation: 6,
              shadowColor: AppColors.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: product.image != null && product.image!.isNotEmpty
                            ? Image.network(
                          product.image!,
                          width: 100.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 100.w,
                            height: 100.h,
                            color: Colors.grey.withOpacity(0.2),
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        )
                            : Container(
                          width: 100.w,
                          height: 100.h,
                          color: Colors.grey.withOpacity(0.2),
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Name
                            Text(
                              product.name,
                              style: FontHelper.cairoBold700(
                                fontSize: 16.sp,
                                color: AppColors.blackColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),

                            // Discount Badge
                            if (product.discount != '0.00')
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade400,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  '${product.discount}% OFF',
                                  style: FontHelper.cairoMedium500(
                                    fontSize: 12.sp,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            SizedBox(height: 6.h),

                            // Price Details
                            Text(
                              'Price: \$${product.price}',
                              style: FontHelper.cairoRegular400(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            if (product.discount != '0.00')
                              Text(
                                'Discounted Price: \$${product.finalPrice}',
                                style: FontHelper.cairoMedium500(
                                  fontSize: 14.sp,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            SizedBox(height: 4.h),

                            // Quantity
                            Text(
                              'Quantity: ${product.quantity}',
                              style: FontHelper.cairoRegular400(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4.h),

                            // Availability Badge
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: product.isAvailable == 1
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                product.isAvailable == 1 ? 'Available' : 'Not Available',
                                style: FontHelper.cairoMedium500(
                                  fontSize: 12.sp,
                                  color: product.isAvailable == 1 ? Colors.green : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Action Buttons
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.mainColor,
                              size: 20.sp,
                            ),
                            onPressed: () {
                              controller.navigateToEditProduct(product);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 20.sp,
                            ),
                            onPressed: () {
                              showDeleteConfirmationDialog(product.id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  void showDeleteConfirmationDialog(int id) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete Product'),
          ],
        ),
        content: Text(
          'Are you sure you want to delete this product?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              await controller.repo.deleteSellerProductsPublished(id);

             },
            icon: Icon(Icons.delete, size: 18, color: Colors.white),
            label: Text('Yes', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

}
