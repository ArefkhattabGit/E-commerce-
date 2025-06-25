import 'package:dio/dio.dart';
import 'package:final_poject_sw_engineering/api/repo/adminCategoryRepo/admin_category_repo.dart';

import '../../../app/app_constatns.dart';
import '../../apiResponse/api_response.dart';
import '../../dio_exceptions.dart';
import '../../dio_service.dart';

class AdminCategoryRepoImpl implements AdminCategoryRepo{
  @override
  Future deleteAdminCategory({required int id})   async {
    try {
      final response = await DioService.dioService
          .delete("${AppConstants.addCategoriesEndPoint}/$id");
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
  Future postUpdateCategory({required dynamic body, required int categoryId}) async {
    try {
      final response = await DioService.dioService.post(
        '${AppConstants.addCategoriesEndPoint}/update/$categoryId',
        data: body,
      );
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