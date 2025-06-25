import 'package:final_poject_sw_engineering/module/productsByCategory/products_by_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widget/custom_product_card_widget.dart';
import '../home/home_controller.dart';
import '../productDetails/productDetails_screen.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  ProductsByCategoryScreen({super.key});


  final controller = Get.put(ProductsByCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.category.name,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.cyanAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

      ),
      body: GetBuilder<ProductsByCategoryController>(
        builder: (controller) => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : controller.tProductByCategory!.data!.data.products.isEmpty
            ? const Center(child: Text('No products found'))
            : ListView.builder(
          itemCount: controller.tProductByCategory!.data!.data.products.length,
          itemBuilder: (context, index) => ProductCard(
            onFavoriteTap: () {
              Get.find<HomeController>().toggleFavoriteStatus(
                controller.tProductByCategory!.data!.data.products[index].id,
              );
            },
            onTap: () => Get.to(() => ProductDetailsScreen(),
                arguments: controller.tProductByCategory!.data!.data.products[index]),
            product: controller.tProductByCategory!.data!.data.products[index],
          ),
        ),
      ),
    );
  }
}
