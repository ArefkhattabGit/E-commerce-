import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:final_poject_sw_engineering/base/base_getx_controller.dart';
import '../../../api/apiResponse/api_response.dart';
import '../../../api/dio_service.dart';
import '../../../api/repo/homeRepo/home_repo_Impl.dart';
import '../../../api/repo/sellerRepo/seller_repo_impl.dart';
import '../../../model/TSellerShowProduct.dart';
import '../../../model/category_model.dart';
import '../../../model/update_products_dashboard_model.dart';
import '../../../model/TUpdate.dart';

class AddSellerProductController extends BaseGetxController {
  final HomeRepoImpl _homeRepoImpl = HomeRepoImpl();
  final SellerRepoImpl sellerRepo = SellerRepoImpl();

  final descriptionController = TextEditingController();
  bool showDescription = false;

  final tabController = Rx<TabController?>(null);
  final RxString networkImageUrl = ''.obs;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final discountController = TextEditingController();

  final Rx<File?> selectedImage = Rx<File?>(null);
  BaseApiResponse<CategoryModel>? tCategory;
  BaseApiResponse<TUpdateProductClassDashboardModel>? updateSellerProducts;

  final isEditing = false.obs;
  int? editingProductId;

  final selectedValue = ''.obs;

  BaseApiResponse<TUpdate>? tUpdate;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {
    setLoading(true);
    update();

    tCategory = await _homeRepoImpl.getCategories();

    if (tCategory?.data?.data.categories.isNotEmpty ?? false) {
      selectedValue.value = tCategory!.data!.data.categories.first.name;
    }

    setLoading(false);
    update();
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
      update();
    }
  }


  Future<void> addProduct() async {
    if (!formKey.currentState!.validate()) return;

    final map = _buildProductMap();
    dynamic dataSent = await prepareFormData(map);

    setLoading(true);
    update();

    final response = await sellerRepo.postCreateProduct(body: dataSent);
    Get.snackbar("نجاح", "تمت إضافة المنتج بنجاح",
        backgroundColor: Colors.green, colorText: Colors.white);
    clearForm();

    setLoading(true);
    update();
  }

  Future<void> updateProduct() async {
    if (!formKey.currentState!.validate() || editingProductId == null) return;

    final map = _buildProductMap();
    dynamic dataSent = await prepareFormData(map);

    setLoading(true);
    update();

    tUpdate = await sellerRepo.UpdateProd(
        productId: editingProductId!, body: dataSent);
    Get.snackbar("نجاح", "تم تحديث المنتج بنجاح",
        backgroundColor: Colors.green, colorText: Colors.white);
    setLoading(false);
    update();
    clearForm();
  }

  Map<String, dynamic> _buildProductMap() {
    return {
      'user_id': 26,
      'name': nameController.text.trim(),
      'price': priceController.text.trim(),
      'slug':nameController.text,
      'quantity': quantityController.text.trim(),
      'discount': discountController.text.trim().isEmpty
          ? '0'
          : discountController.text.trim(),
      'category_id': getCategoryIdByName(selectedValue.value),
      'description': showDescription ? descriptionController.text.trim() : '',
    };
  }

  Future<dynamic> prepareFormData(Map<String, dynamic> map) async {
    if (selectedImage.value != null) {
      return await addFormDataToJson(
        jsonKey: 'image',
        filePath: selectedImage.value!.path,
        fileName: selectedImage.value!.path.split('/').last,
        jsonObject: map,
      );
    } else {
      return map;
    }
  }

  int getCategoryIdByName(String name) {
    final cat = tCategory?.data?.data.categories
        .firstWhereOrNull((c) => c.name == name);
    return cat?.id ?? 0;
  }

  void onChanged(String? value) {
    selectedValue.value = value ?? '';
  }

  void fillFormWithProductData(SellerProduct product) {
    nameController.text = product.name;
    priceController.text = product.price;
    discountController.text = product.discount;
    quantityController.text = product.quantity.toString();
    selectedValue.value = product.category?.name ??
        tCategory?.data?.data.categories.first.name ?? '';
    networkImageUrl.value = product.image ?? '';
    isEditing.value = true;
    editingProductId = product.id;
    descriptionController.text = product.description ?? '';
    showDescription = product.description != null && product.description!.isNotEmpty;
  }

  void clearForm() {
    nameController.clear();
    priceController.clear();
    quantityController.clear();
    discountController.clear();
    descriptionController.clear();
    selectedImage.value = null;
    networkImageUrl.value = '';
    isEditing.value = false;
    editingProductId = null;
    showDescription = false;
    update();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    discountController.dispose();
    descriptionController.dispose();
    tabController.value?.dispose();
    super.dispose();
  }
}
