import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app/app_colors.dart';
import '../app/app_dimensions.dart';
import '../helper/font_helper.dart';
import '../widget/custom_outline_button_widget.dart';

class Utils {
  Utils._();

  static void showSnackBar({
    required String? message,
    SnackBarType? type,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.closeCurrentSnackbar();

    final backgroundColor = _getBackgroundColor(type);

    Get.snackbar(
      type?.name.toUpperCase() ?? 'INFO',
      message ?? 'snack bar message',
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: duration,
    );
  }

  static Color? _getBackgroundColor(SnackBarType? type) {
    return switch (type) {
      SnackBarType.error => Colors.red[700],
      SnackBarType.success => Colors.green[700],
      SnackBarType.info => Colors.blue[700],
      null => Colors.grey,
    };
  }

  // static showDialog({
  //   String? title,
  //   String? subtitle,
  //   String? submitBtnTxt,
  //   String? cancelBtnTxt,
  //   required Function() onSubmitPressed,
  // }) {
  //   Get.dialog(
  //     Dialog(elevation: 0,
  //       child: Container(
  //         width: 356.sw,
  //         decoration: BoxDecoration(
  //           color: AppColors.white,
  //           borderRadius: BorderRadius.circular(AppDimensions.rCornerMedium_12),
  //         ),
  //         child: Padding(
  //           padding:  EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
  //           child: Column(
  //              mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(
  //                 title ?? 'تسجيل الخروج',
  //                 style: FontHelper.cairoSemiBold600(
  //                   color: AppColors.blackColor08,
  //                 ),
  //               ),
  //               SizedBox(height: 12.h),
  //               Text(
  //                 textAlign:TextAlign.center,
  //                 subtitle ?? 'هل حقاً تريد تسجيل الخروج من حسابك؟',
  //                 style: FontHelper.cairoMedium500(
  //                   fontSize: 12.sp,
  //                   color: AppColors.blackColor08,
  //                 ),
  //               ),
  //               SizedBox(height: 16.h),
  //
  //               CustomButton(
  //                 backgroundColor: AppColors.redColorFF0000,
  //                 height: 42.h,
  //                 text: submitBtnTxt ?? 'تسجيل الدخول',
  //                 showIcon: false,
  //                 onPressed: onSubmitPressed,
  //               ),
  //               SizedBox(height: 8.h),
  //
  //               GestureDetector(
  //                 onTap: () => Get.back(),
  //                 child: Container(
  //                   padding: EdgeInsets.zero,
  //                   margin: EdgeInsets.zero,
  //                   height: 42.h,
  //                   width: double.infinity,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(
  //                       AppDimensions.rCornerSmall_8,
  //                     ),
  //                     color: AppColors.white,
  //                     border: Border.all(
  //                       color: AppColors.blackColor08,
  //                       width: 1,
  //                     ),
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       cancelBtnTxt ?? 'إلغاء',
  //                       style: FontHelper.cairoMedium500(),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               // Buttons
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

enum SnackBarType { error, success, info }
