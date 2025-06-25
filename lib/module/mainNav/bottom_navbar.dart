import 'package:final_poject_sw_engineering/module/mainNav/bottom_navbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbarScreen extends StatelessWidget {
  BottomNavbarScreen({super.key});

  final BottomNavbarController controller = Get.find<BottomNavbarController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => controller.changeIndex(value),
          items: controller.items,
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
        ),
        body: controller.screens[controller.currentIndex.value]),

    );
  }

}
