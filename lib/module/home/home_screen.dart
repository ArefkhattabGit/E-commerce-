import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_poject_sw_engineering/module/home/home_controller.dart';
import 'package:final_poject_sw_engineering/module/productDetails/productDetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/home_model.dart';
import '../../widget/custom_product_card_widget.dart';
import '../../widget/cutom_category_card_widget.dart';
import '../productsByCategory/products_by_category_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              print('Search button pressed');
            },
          ),
        ],
        title: Text(
          'Online Shop',
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
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Carousel Slider
              SliverToBoxAdapter(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                      items: List.generate(
                        controller.sliderImage.length,
                            (index) => Image.asset(
                          controller.sliderImage[index],
                          fit: BoxFit.fitHeight,
                          width: double.infinity,
                        ),
                      ),
                      carouselController: controller.carouselController,
                      options: CarouselOptions(
                        height: 250.h,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.easeOutSine,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        onPageChanged: (index, reason) {
                          controller.currentIndex = index;
                          controller.update();
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: double.infinity,
                      foregroundDecoration:
                      const BoxDecoration(color: Colors.white12),
                      child: AnimatedSmoothIndicator(
                        activeIndex: controller.currentIndex,
                        count: controller.sliderImage.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 4,
                          dotWidth: 8,
                          spacing: 6,
                          activeDotColor: Colors.orangeAccent,
                          dotColor: Colors.white,
                        ),
                        onDotClicked: (index) {
                          controller.carouselController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),
              // Categories Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 8.h),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 150.h,
                  child:  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 8.h),
                    itemCount: controller.tCategory?.data?.data
                        .categories.length ??
                        0,
                    itemBuilder: (context, index) {
                      final category = controller.tCategory?.data
                          ?.data.categories[index];
                      if (category == null) {
                        return const SizedBox.shrink();
                      }
                      return CategoryCard(category: category,onTap: () {
                        print('Tapped category ${category}');
                        Get.to(()=>ProductsByCategoryScreen(),arguments:controller.tCategory?.data?.data
                            .categories[index]);

                      },);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              // Products Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 8.h),
                  child: Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 0.65,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final List<Product> products = controller.tHome!.data!.data.products.reversed.toList();
                      final Product product = products[index];
                      return ProductCard(
                        onFavoriteTap: () {
                          controller.toggleFavoriteStatus(product.id);
                        },
                        onTap: ()=>Get.to(()=>ProductDetailsScreen(),arguments: product),
                        product: product,
                      );
                    },
                    childCount: controller.tHome!.data!.data.products.length,
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}


