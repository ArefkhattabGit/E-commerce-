import 'package:final_poject_sw_engineering/base/base_getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/apiResponse/api_response.dart';
import '../../../api/repo/sellerRepo/seller_repo_impl.dart';
import '../../../model/TSellerShowProduct.dart';
import '../sellerDashboard/add_seller_product_controller.dart';
import '../sellerDashboard/add_seller_product_screen.dart';

class DisplaySellerProductsController extends BaseGetxController {
  final SellerRepoImpl repo = SellerRepoImpl();

  final addProductController = Get.find<AddSellerProductController>();

  BaseApiResponse<TSellerShowSellerProduct>? tProductsSellers;

  Future<void> getSellerProductsPublished() async {
    setLoading(true);
    update();

    tProductsSellers = await repo.getSellerProductsPublished();

    setLoading(false);
    update();
  }

  void navigateToEditProduct(product) {
    addProductController.fillFormWithProductData(product);
    Get.to(() => AddSellerProductScreen(isFromAddSellerProductScreen: true));
  }

  deleteSellerProductsPublished(int id) async {
    await repo.deleteSellerProductsPublished(id);
    Get.back();

    final snackBar = SnackBar(
      content: Text('Product successfully deleted.'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

    getSellerProductsPublished();
    update();
  }
}
