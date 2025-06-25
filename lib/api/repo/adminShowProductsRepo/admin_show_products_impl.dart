import 'package:dio/dio.dart';
import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/api/repo/adminShowProductsRepo/admin_show_products_repo.dart';
import 'package:final_poject_sw_engineering/model/home_model.dart';

import '../../../app/app_constatns.dart';
import '../../dio_exceptions.dart';
import '../../dio_service.dart';

class AdminShowProductsImpl implements AdminShowProductsRepo {
  @override
  Future<BaseApiResponse<HomeModel>> getProductsAdminDashBoard() async {
    try {
      final response =
          await DioService.dioService.get(AppConstants.homeEndpoint);
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(HomeModel.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future deleteProductsAdminDashBoard({required int id}) async {
    try {
      final response = await DioService.dioService.delete('${AppConstants.addProductsEndpoint}/$id');
      if (response.statusCode == 200) {
        print(response.data);
        return BaseApiResponse.completed(response.data);
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }
}
