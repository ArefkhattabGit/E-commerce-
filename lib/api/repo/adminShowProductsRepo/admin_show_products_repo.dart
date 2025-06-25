import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/model/home_model.dart';

abstract class AdminShowProductsRepo {

  Future<BaseApiResponse<HomeModel>> getProductsAdminDashBoard();
  Future deleteProductsAdminDashBoard({required int id});
}