import 'package:final_poject_sw_engineering/module/home/home_controller.dart';
import 'package:final_poject_sw_engineering/module/mainNav/bottom_navbar_controller.dart';
import 'package:final_poject_sw_engineering/module/profile/profile_controller.dart';
import 'package:final_poject_sw_engineering/module/register/register_controller.dart';
import 'package:get/get.dart';

import '../module/complaint/complaint_controller.dart';
import '../module/login/login_controller.dart';
import '../module/productsByCategory/products_by_category_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<RegisterController>(() => RegisterController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<ProfileController>(()=>ProfileController(), fenix: true);
    Get.lazyPut<BottomNavbarController>(()=>BottomNavbarController(), fenix: true);
    Get.lazyPut<ProductsByCategoryController>(()=>ProductsByCategoryController(), fenix: true);
    Get.lazyPut<ComplaintController>(()=>ComplaintController(), fenix: true);


  }
}
