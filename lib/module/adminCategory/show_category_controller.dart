import 'dart:io';

import 'package:final_poject_sw_engineering/api/repo/adminCategoryRepo/admin_category_repo_impl.dart';
import 'package:final_poject_sw_engineering/base/base_getx_controller.dart';
import 'package:final_poject_sw_engineering/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api/apiResponse/api_response.dart';
import '../../model/category_model.dart';
import '../home/home_controller.dart';

class ShowCategoryController extends BaseGetxController {

  final Rx<File?> updatedImage = Rx<File?>(null);
  final TextEditingController nameController = TextEditingController();

  AdminCategoryRepoImpl repoImpl = AdminCategoryRepoImpl();

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  BaseApiResponse<CategoryModel>? tCategory;

  Future<void> getCategories() async {
    setLoading(true);
    update();
    tCategory = await Get
        .find<HomeController>()
        .homeRepoImpl
        .getCategories();
    setLoading(false);
    update();
  }

  deleteAdminCategory(id) async {
    await repoImpl.deleteAdminCategory(id: id);
    await getCategories();
    Utils.showSnackBar(message: 'Category Deleted successfully');
  }






}