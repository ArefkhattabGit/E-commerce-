import 'package:final_poject_sw_engineering/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/apiResponse/api_response.dart';
import '../../api/repo/authRepo/auth_repo_Impl.dart';
import '../../app/app_config.dart';
import '../../app/app_constatns.dart';
import '../../base/base_getx_controller.dart';
import '../../model/login_model.dart';

class LoginController extends BaseGetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;

  final AuthRepoImpl _repo = AuthRepoImpl();


  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  BaseApiResponse<LoginModel>? tUser;

  void login() async {
    if (formKey.currentState!.validate()) {
      final Map<String, dynamic> body = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      tUser = await _repo.postUserLogin(body: body);
      if (tUser == null) return;
      await AppConfig.setString(AppConstants.USER_TOKEN, tUser!.data!.token);
      update();
      print(tUser!.data!.token);

      // Navigate based on user role
      final roles = tUser!.data!.data.roles;
      String? roleName = roles.isNotEmpty ? roles[0].name : null;
      await AppConfig.setString(AppConstants.USER_ROLE, roleName.toString());

      print('User role: ${roleName ?? null}');

      if (roleName == 'admin') {
        Get.offAndToNamed(AppRoutes.adminDashboardScreen);
      } else if (roleName == 'seller') {
        Get.offAndToNamed(AppRoutes.sellerDashboard);
      } else {
        Get.offAndToNamed(AppRoutes.bottomNavScreen);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}