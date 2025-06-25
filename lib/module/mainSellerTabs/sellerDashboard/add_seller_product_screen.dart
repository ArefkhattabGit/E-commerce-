import 'dart:io';
import 'package:final_poject_sw_engineering/module/mainSellerTabs/sellerDashboard/add_seller_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_dimensions.dart';
import '../../../helper/custom_text_field_helper.dart';
import '../../../helper/font_helper.dart';
import '../../../widget/drop_down_widget.dart';

class AddSellerProductScreen extends StatelessWidget {
  final bool isFromAddSellerProductScreen;
  AddSellerProductScreen({super.key, this.isFromAddSellerProductScreen = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFromAddSellerProductScreen
          ? AppBar(
        title: Text(
          'Update Product',
          style: FontHelper.cairoBold700(
            fontSize: 20.sp,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      )
          : null,
      backgroundColor: AppColors.white,
      body: GetBuilder<AddSellerProductController>(
        builder: (controller) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFieldHelper(
                  controller: controller.nameController,
                  hintText: 'Product Name',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter product name'
                      : null,
                ),
                SizedBox(height: 16.h),

                DropdownWidget(
                  items: List.generate(
                    controller.tCategory?.data?.data.categories.length ?? 0,
                        (index) => controller
                        .tCategory!.data!.data.categories[index].name,
                  ),
                  value: controller.selectedValue.value.isEmpty
                      ? null
                      : controller.selectedValue.value,
                  onChanged: controller.onChanged,
                ),
                SizedBox(height: 16.h),

                CustomTextFieldHelper(
                  controller: controller.priceController,
                  hintText: 'Price',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter price';
                    if (double.tryParse(value) == null) return 'Enter valid price';
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                CustomTextFieldHelper(
                  controller: controller.discountController,
                  hintText: 'Discount',
                  validationType: InputValidationType.none,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        double.tryParse(value) == null) {
                      return 'Enter valid discount';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                CustomTextFieldHelper(
                  controller: controller.quantityController,
                  hintText: 'Quantity',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter quantity';
                    if (int.tryParse(value) == null) return 'Enter valid quantity';
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                // Description Switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add description?',
                      style: FontHelper.cairoMedium500(
                        fontSize: 16.sp,
                        color: AppColors.mainColor,
                      ),
                    ),
                    Switch(
                      value: controller.showDescription,
                      onChanged: (val) {
                        controller.showDescription = val;
                        controller.update();
                      },
                      activeColor: AppColors.mainColor,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                if (controller.showDescription)
                  Column(
                    children: [
                      CustomTextFieldHelper(
                        controller: controller.descriptionController,
                        hintText: 'Product Description',
                        validator: (value) {
                          if (controller.showDescription &&
                              (value == null || value.isEmpty)) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),

                // Image Picker and Display
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.selectedImage.value != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          controller.selectedImage.value!,
                          height: 180.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (controller.networkImageUrl.value.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          controller.networkImageUrl.value,
                          height: 180.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 180.h,
                            width: double.infinity,
                            color: Colors.grey.withOpacity(0.2),
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 10.h),
                    OutlinedButton.icon(
                      onPressed: () async {
                        await controller.pickImage();
                      },
                      icon: const Icon(Icons.image),
                      label: Text(
                        controller.selectedImage.value == null &&
                            controller.networkImageUrl.value.isEmpty
                            ? 'Choose Image'
                            : 'Change Image',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),

                ElevatedButton(
                  onPressed: () async {
                    if (controller.isEditing.value) {
                      await controller.updateProduct();
                    } else {
                      await controller.addProduct();
                    }
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
                    controller.isEditing.value ? 'Update Product' : 'Publish Product',
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
