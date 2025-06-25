import 'package:dio/dio.dart';
import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/model/category_model.dart';
import 'package:final_poject_sw_engineering/model/favorites_model.dart';
import 'package:final_poject_sw_engineering/model/home_model.dart';

import '../../../app/app_constatns.dart';
import '../../../model/TCategory.dart';
import '../../../model/favorite_model.dart';
import '../../dio_exceptions.dart';
import '../../dio_service.dart';
import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  Future<BaseApiResponse<HomeModel>> getAllProduct(
      {Map<String, dynamic> ?query}) async {
    try {
      final response = await DioService.dioService.get(
          AppConstants.homeEndpoint, queryParameters: query);
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
  Future<BaseApiResponse<TCategory>> getProductByCategoryId(
      int id) async {
    try {
      final response = await DioService.dioService.get(
          "${AppConstants.productByCategoryEndPoint}/$id");
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(TCategory.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse<CategoryModel>> getCategories() async {
    try {
      final response = await DioService.dioService.get(
          AppConstants.categoryEndPoint);
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(CategoryModel.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse<FavoriteModel>> postAddToFavorite(int id) async {
    try {
      final response = await DioService.dioService
          .post("${AppConstants.addRemoveFavoritesEndPoint}/$id");
      if (response.statusCode == 200 ) {
        return BaseApiResponse.completed(FavoriteModel.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse> postRemoveToFavorite(int id) async {
    try {
      final response = await DioService.dioService
          .delete("${AppConstants.addRemoveFavoritesEndPoint}/$id");
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(response.data);
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse<FavoritesModel>> getUserFavorite() async {
    try {
      final response = await DioService.dioService.get(
          AppConstants.addRemoveFavoritesEndPoint);
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(FavoritesModel.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }
}