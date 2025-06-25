import 'package:final_poject_sw_engineering/helper/font_helper.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/app_colors.dart';
import '../app/app_dimensions.dart';

class DropdownWidget extends StatelessWidget {
  final List<String> items;
  final String? value;
  Function(String?)? onChanged;
  final String? hintText;
  final TextStyle? style;

  DropdownWidget({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hintText,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(

          isExpanded: true,
          value: value,
          hint: Text(
            hintText ??'',
            style: FontHelper.cairoSemiBold600(
                color: AppColors.textPrimary, fontSize: 13.sp),
          ),
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: FontHelper.cairoSemiBold600(
                    color: AppColors.textPrimary, fontSize: 14.sp),
              ),
            );
          }).toList(),
          buttonStyleData: ButtonStyleData(

            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.6, // Border width
              ),
              borderRadius: BorderRadius.circular(AppDimensions.rCornerSmall_8),

            ),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            elevation: 0,
          ),
          dropdownStyleData: DropdownStyleData(
             width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:
              BorderRadius.circular(AppDimensions.rCornerSmall_8), // Added radius for rounded corners
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down_rounded),
            iconSize: 24,
            iconEnabledColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}