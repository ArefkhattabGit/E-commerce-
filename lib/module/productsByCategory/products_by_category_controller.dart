import 'package:final_poject_sw_engineering/base/base_getx_controller.dart';
import 'package:final_poject_sw_engineering/module/home/home_controller.dart';
import 'package:get/get.dart';

import '../../api/apiResponse/api_response.dart';
import '../../api/repo/homeRepo/home_repo_Impl.dart';
import '../../model/TCategory.dart';
import '../../model/category_model.dart';

class ProductsByCategoryController extends BaseGetxController {
  BaseApiResponse<TCategory>? tProductByCategory;


  final Category category = Get.arguments;


  @override
  void onInit() {
    print('id ====>${category.id}');
     super.onInit();
     getProductByCategoryId(category.id);
  }

  final HomeRepoImpl repoImpl = HomeRepoImpl();

  Future<void> getProductByCategoryId(int id) async {
    setLoading(true);
    update();
    tProductByCategory = await repoImpl.getProductByCategoryId(id);
    setLoading(false);
    update();
  }
}
