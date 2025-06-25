import 'package:dio/dio.dart';
import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/api/dio_exceptions.dart';
import 'package:final_poject_sw_engineering/api/repo/sellerRepo/seller_repo.dart';
import 'package:final_poject_sw_engineering/app/app_constatns.dart';
import 'package:final_poject_sw_engineering/model/TSellerCreateProduct.dart';
import 'package:final_poject_sw_engineering/model/TSellerShowProduct.dart';
import 'package:final_poject_sw_engineering/model/TUpdate.dart';
import 'package:final_poject_sw_engineering/model/update_products_dashboard_model.dart';

import '../../dio_service.dart';

class SellerRepoImpl implements SellerRepo {
  @override
  Future<BaseApiResponse<TSellerCreateProduct>> postCreateProduct(
      {required dynamic body}) async {
    try {
      final response = await DioService.dioService
          .post(AppConstants.addProductsEndpoint, data: body);
      if (response.statusCode == 200) {
        print(response.data);
        return BaseApiResponse.completed(TSellerCreateProduct.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e.toString());
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse<TSellerShowSellerProduct>>
      getSellerProductsPublished() async {
    try {
      final response =
          await DioService.dioService.get(AppConstants.addProductsEndpoint);
      if (response.statusCode == 200) {
        print(response.data);
        return BaseApiResponse.completed(
            TSellerShowSellerProduct.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse> deleteSellerProductsPublished(int id) async {
    try {
      final response = await DioService.dioService
          .delete('${AppConstants.addProductsEndpoint}/$id');
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

  @override
  Future<BaseApiResponse<TUpdateProductClassDashboardModel>>
      putUpdateSellerProductPublished(
          {required int id, required body}) async {
    try {
      final response = await DioService.dioService.post(
        '${AppConstants.addProductsEndpoint}/update/$id',
        data: body,options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',

        }

      ));
      if (response.statusCode == 200) {
        print(response.data);
        return BaseApiResponse.completed(
            TUpdateProductClassDashboardModel.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse<TUpdate>> UpdateProd({required int productId, dynamic body})async {
    try {
      final response = await DioService.dioService.post(
          '${AppConstants.addProductsEndpoint}/update/$productId',
        data: body,
       );
      if (response.statusCode == 200) {
        print(response.data);
        return BaseApiResponse.completed(TUpdate.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

}
