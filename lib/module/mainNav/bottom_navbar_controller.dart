import 'package:final_poject_sw_engineering/app/app_config.dart';
import 'package:final_poject_sw_engineering/app/app_constatns.dart';
import 'package:final_poject_sw_engineering/base/base_getx_controller.dart';
import 'package:final_poject_sw_engineering/module/favorite/favorite_screen.dart';
import 'package:final_poject_sw_engineering/module/home/home_screen.dart';
import 'package:final_poject_sw_engineering/module/profile/profile_screen.dart';
import 'package:final_poject_sw_engineering/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../setting/setting_screen.dart';

class BottomNavbarController extends BaseGetxController {
  RxInt currentIndex = 0.obs;

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      activeIcon: Icon(Icons.home_filled),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
      activeIcon: Icon(Icons.person),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      label: 'Favorite',
      activeIcon: Icon(Icons.favorite),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  final List<Widget> screens = [
    HomeScreen(),
    ProfileScreen(),
    FavoriteScreen(),
    SettingScreen()

  ];

  void changeIndex(value) {
    currentIndex.value = value;
  }
}
