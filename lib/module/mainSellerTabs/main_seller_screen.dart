import 'package:final_poject_sw_engineering/module/mainSellerTabs/sellerDashboard/add_seller_product_controller.dart';
import 'package:final_poject_sw_engineering/module/mainSellerTabs/sellerDashboard/add_seller_product_screen.dart';
import 'package:final_poject_sw_engineering/module/mainSellerTabs/displaySellerProducts/display_seller_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_colors.dart';
import '../../../helper/font_helper.dart';
import '../../../app/app_config.dart';
import '../../../app/app_constatns.dart';
import '../../../routes/app_routes.dart';

class MainSellerScreen extends StatelessWidget {
  MainSellerScreen({super.key});

  final controller = Get.put(AddSellerProductController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          controller.tabController.value = DefaultTabController.of(context);
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              actions: [
                InkWell(
                  onTap: () {
                    AppConfig.remove(AppConstants.USER_TOKEN);
                    AppConfig.remove(AppConstants.USER_ROLE);
                    Get.offAndToNamed(AppRoutes.loginScreen);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.exit_to_app,color: Colors.white,),
                  ),
                ),
              ],
              title: Text(
                'Seller Dashboard',
                style: FontHelper.cairoBold700(
                  fontSize: 20.sp,
                  color: AppColors.white,
                ),
              ),
              centerTitle: true,
              backgroundColor: AppColors.mainColor,
              bottom: const TabBar(
                labelColor: AppColors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: AppColors.white,
                tabs: [
                  Tab(text: 'Add Product'),
                  Tab(text: 'My Products'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                AddSellerProductScreen(),
                DisplaySellerProducts(),
              ],
            ),
          );
        },
      ),
    );
  }
}
