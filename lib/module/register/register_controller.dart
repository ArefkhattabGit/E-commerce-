import 'package:final_poject_sw_engineering/api/repo/authRepo/auth_repo_Impl.dart';
import 'package:final_poject_sw_engineering/app/app_config.dart';
import 'package:final_poject_sw_engineering/app/app_constatns.dart';
import 'package:final_poject_sw_engineering/model/register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api/apiResponse/api_response.dart';
import '../../base/base_getx_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/utils.dart';

class RegisterController extends BaseGetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  final AuthRepoImpl _repo = AuthRepoImpl();

  @override
  void onInit() {
    super.onInit();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  BaseApiResponse<RegisterModel>? tUser;

  void register() async {
    if (formKey.currentState!.validate()) {
      final Map<String, dynamic> body = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': confirmPasswordController.text,
      };
      tUser = await _repo.postUserRegister(body: body);
      print(tUser!.data!.token);

      await AppConfig.setString(AppConstants.USER_TOKEN, tUser!.data!.token);

      print(tUser!.data!.token);

      Get.toNamed(AppRoutes.bottomNavScreen);

      // Utils.showSnackBar(message: tUser!.message, type: SnackBarType.success);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}
