import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/app_colors.dart';
import '../app/app_dimensions.dart';
import '../helper/font_helper.dart';

class CustomOutlineButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onPressedPrefixText;
  final String prefixText;
  final String? suffixText;
  final Widget? suffixWidget;
  final Color? prfxColorText;
  final bool showSuffixIcon;

  CustomOutlineButtonWidget({
    Key? key,
    required this.onPressed,
    this.onPressedPrefixText,
    this.prefixText = 'لدي حساب بالفعل',
    this.suffixText = 'تسجيل الدخول',
    this.suffixWidget,
    this.prfxColorText = AppColors.blackColor08,
    this.showSuffixIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;
    // Check if we're on web/desktop
    final isLargeScreen = screenWidth > 600;

    // Calculate responsive dimensions
    final containerHeight = isLargeScreen ? 48.0 : 58.h;
    final containerWidth = isLargeScreen
        ? (screenWidth > 1200 ? 400.0 : screenWidth * 0.3)
        : double.infinity;
    final horizontalPadding = isLargeScreen ? 16.0 : 16.w;
    final verticalPadding = isLargeScreen ? 8.0 : 16.h;
    final fontSize = isLargeScreen ? 14.0 : 14.sp;
    final borderWidth = isLargeScreen ? 1.0 : 1.w;
    final borderRadius = isLargeScreen ? 8.0 : AppDimensions.rCornerSmall_8;
    final iconSize = isLargeScreen ? 20.0 : 24.0;

    return Center(
      child: Container(
        height: containerHeight,
        width: containerWidth,
        constraints: BoxConstraints(
          maxWidth: isLargeScreen ? 400.0 : double.infinity,
          minWidth: isLargeScreen ? 200.0 : double.infinity,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.greyColor000,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onPressedPrefixText,
              child: Text(
                prefixText,
                style: FontHelper.cairoMedium500(
                  fontSize: fontSize,
                  color: prfxColorText!,
                ),
              ),
            ),
            GestureDetector(
              onTap: onPressed,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (suffixWidget != null)
                    suffixWidget!
                  else
                    Text(
                      suffixText!,
                      style: FontHelper.cairoMedium500(
                        fontSize: fontSize,
                        color: AppColors.mainColor,
                      ),
                    ),
                  if (showSuffixIcon) ...[
                    SizedBox(width: isLargeScreen ? 5.0 : 5.w),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.mainColor,
                      size: iconSize,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}