import 'package:final_poject_sw_engineering/api/repo/adminShowProductsRepo/admin_show_products_impl.dart';
import 'package:final_poject_sw_engineering/api/repo/homeRepo/home_repo_Impl.dart';
import 'package:final_poject_sw_engineering/base/base_getx_controller.dart';
import 'package:get/get.dart';

import '../../../api/apiResponse/api_response.dart';
import '../../../model/home_model.dart';

class ShowAdminDashboardProductsController  extends BaseGetxController{
  HomeRepoImpl homeRepoImpl  = HomeRepoImpl();
  AdminShowProductsImpl adminShowProductsImpl= AdminShowProductsImpl();

  BaseApiResponse<HomeModel>? tHome;



  @override
  void onInit() {
    super.onInit();
    getAllProducts();
  }
  Future<void> getAllProducts() async {
    setLoading(true);
    update();
    tHome = await homeRepoImpl.getAllProduct();
    setLoading(false);
    update();
  }

  Future<void> deleteProductsAdminDashBoard(int id)async{

    await adminShowProductsImpl.deleteProductsAdminDashBoard(id: id);
    Get.back();

    Get.snackbar("Deleted", "Product has been deleted.");


    getAllProducts();
  }
}