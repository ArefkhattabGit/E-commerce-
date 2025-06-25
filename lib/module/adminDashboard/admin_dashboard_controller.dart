import 'dart:io';

import 'package:final_poject_sw_engineering/api/dio_service.dart';
import 'package:final_poject_sw_engineering/api/repo/manageUsersRepo/manage_user_repo_impl.dart';
import 'package:final_poject_sw_engineering/model/TManageUsers.dart';
import 'package:final_poject_sw_engineering/model/TUserStatus.dart';
import 'package:final_poject_sw_engineering/module/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../api/apiResponse/api_response.dart';
import '../../base/base_getx_controller.dart';
import '../../model/TAddCategory.dart';
import '../../model/category_model.dart';
import '../../utils/utils.dart';

class AdminDashboardController extends BaseGetxController {
  final ManageUserRepoImpl repoImpl = ManageUserRepoImpl();

  final TextEditingController categoryNameController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  BaseApiResponse<TAddCategory> ? tAddCategory;

  BaseApiResponse<TManageUsers>? users;
  BaseApiResponse<TUserStatus>? userStatus;


  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    setLoading(true);
    update();

    try {
      users = await repoImpl.getAdminAllUsers();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users');
      print('Fetch users error: $e');
    }

    setLoading(false);
    update();
  }



  deleteUser(id) async {
    await repoImpl.deleteRemoveUser(id: id);
    users =  await repoImpl.getAdminAllUsers();
    Utils.showSnackBar(message: 'Success Remove The User',type:SnackBarType.success );

    update();
  }

  void toggleUserStatus(int index) async {
    final user = users!.data!.data[index];
    final newStatus = user.status == 'active' ? 'inactive' : 'active';

    // Optimistic UI update
    user.status = newStatus;
    update();

    await postChangeUserStatus(userId: user.id, status: newStatus);
  }

  Future<void> postChangeUserStatus(
      {required int userId, required String status}) async {
    try {
      userStatus = await repoImpl.postChangeUserStatus(
        id: userId,
        body: {
          'id': userId,
          'status': status,
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong while updating status');
      print('Status update error: $e');
    }
  }
  Future<void> addCategory() async {
    final name = categoryNameController.text.trim();
    final imageFile = selectedImage.value;

    if (name.isEmpty || imageFile == null) {
      Utils.showSnackBar(
        message: 'Please provide both name and image.',
        type: SnackBarType.error,
      );
      return;
    }

    try {
      final dataSent = await addFormDataToJson(
        jsonKey: 'image',
        filePath: imageFile.path,
        fileName: imageFile.path.split('/').last,
        jsonObject: {'name': name},
      );

      tAddCategory = await repoImpl.postAddAdminCategory(body: dataSent);

      Utils.showSnackBar(
        message: 'Category added successfully',
        type: SnackBarType.success,
      );
    } catch (e) {
      Utils.showSnackBar(message: 'Failed to add category', type: SnackBarType.error);
      print("Add category error: $e");
    }
  }
}
