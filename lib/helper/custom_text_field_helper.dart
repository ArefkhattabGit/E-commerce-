import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/app_colors.dart';
import '../app/app_dimensions.dart';
import 'font_helper.dart';

enum InputValidationType {
  none,
  name,
  email,
  telegramUser,
  password,
  phoneNumber,
  location,
  currentLocation,
  bankAccountNumber,
}

class CustomTextFieldHelper extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final InputValidationType validationType;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final Widget? suffixIcon;
  final bool isOptional;
  final String? Function(String?)? validator;
  final TextStyle? style;

  CustomTextFieldHelper({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validationType = InputValidationType.none,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.enabled = true,
    this.suffixIcon,
    this.isOptional = false,
    this.validator,
    this.style,
  }) : super(key: key);

  String? _validateInput(String? value) {
    if (validationType == InputValidationType.none) return null;

    if (value == null || value.trim().isEmpty) {
      return "هذا الحقل مطلوب";
    }
    switch (validationType) {
      case InputValidationType.name:
        if (value.length < 3) {
          return "يجب أن يحتوي الاسم على 3 أحرف على الأقل";
        }
        break;

      case InputValidationType.email:
        if (!RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        ).hasMatch(value)) {
          return "البريد الإلكتروني غير صالح";
        }
        break;

      case InputValidationType.telegramUser:
        if (!value.startsWith('@')) {
          return "يجب أن يبدأ اسم المستخدم بـ @";
        }
        break;

      case InputValidationType.password:
        if (value.length < 6) {
          return "يجب أن تحتوي كلمة المرور على 6 أحرف على الأقل";
        }
        break;

      case InputValidationType.phoneNumber:
        if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
          return "رقم الهاتف غير صالح";
        }
        break;

      case InputValidationType.location:
      case InputValidationType.currentLocation:
        if (value.length < 3) {
          return "الموقع غير صالح";
        }
        break;

      case InputValidationType.bankAccountNumber:
        if (!RegExp(r'^\d{10,20}$').hasMatch(value)) {
          return "رقم الحساب البنكي غير صالح";
        }
        break;

      case InputValidationType.none:
        return null;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style ?? FontHelper.cairoMedium500(color: AppColors.blackColor08),
      enabled: enabled,
      cursorErrorColor: AppColors.mainColor,
      cursorColor: AppColors.mainColor,
      cursorHeight: 13.h,
      cursorRadius: Radius.circular(8.r),
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      validator: validator ?? _validateInput,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: suffixIcon,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rCornerSmall_8),
          borderSide: BorderSide(color: AppColors.greyColor000, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rCornerSmall_8),
          borderSide: BorderSide(color: AppColors.greyColor000, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rCornerSmall_8),
          borderSide: BorderSide(color: AppColors.greyColor000, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rCornerSmall_8),
          borderSide: BorderSide(color: AppColors.greyColor000, width: 1.w),
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rCornerSmall_8),
          borderSide: BorderSide(color: AppColors.greyColor000, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rCornerSmall_8),
          borderSide: BorderSide(color: AppColors.redColor, width: 0.8.w),
        ),
        // labelStyle: FontHelper.cairoMedium500(
        //   color: AppColors.blackColor08,
        // ),
        label: RichText(
          text: TextSpan(
            text: hintText,
            style: FontHelper.cairoMedium500(
              color: AppColors.blackColor08,
            ),
            children: isOptional
                ? [
                    TextSpan(
                      text: " (اختياري)", // Optional text
                      style: FontHelper.cairoMedium500(
                        color: AppColors.greyColor292D32, // Lighter color
                        fontSize: 14,
                      ),
                    ),
                  ]
                : null,
          ),
        ),
        errorStyle: FontHelper.cairoLight300(
          color: AppColors.redColor,
          fontSize: 14,
        ),
        hintStyle: FontHelper.cairoMedium500(
          color: AppColors.blackColor08,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
