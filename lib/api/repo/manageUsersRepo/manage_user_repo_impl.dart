import 'package:dio/dio.dart';
import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/api/dio_exceptions.dart';
import 'package:final_poject_sw_engineering/api/repo/manageUsersRepo/manage_user_repo.dart';
import 'package:final_poject_sw_engineering/model/TManageUsers.dart';

import '../../../app/app_constatns.dart';
import '../../../model/TAddCategory.dart';
import '../../../model/TUserStatus.dart';
import '../../dio_service.dart';

class ManageUserRepoImpl implements AdminManageRepo {
  @override
  Future<BaseApiResponse<TManageUsers>> getAdminAllUsers(
      { Map<String, dynamic>? query}) async {
    try {
      final response = await DioService.dioService
          .get(AppConstants.getAllUsersEndPoint, queryParameters: query);
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(TManageUsers.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse<TUserStatus>> postChangeUserStatus(
      {required int id ,required Map<String, dynamic> body}) async {
    try {
      final response = await DioService.dioService
          .post('${AppConstants.postChangeUsersStatusEndPoint}/$id', data: body);
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(TUserStatus.fromJson(response.data) );
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse> deleteRemoveUser({required int id})  async {
    try {
      final response = await DioService.dioService
          .delete("${AppConstants.getAllUsersEndPoint}/$id");
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
  Future<BaseApiResponse<TAddCategory>> postAddAdminCategory({dynamic body})async {
    try {
      final response = await DioService.dioService
          .post(AppConstants.addCategoriesEndPoint,options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',

        }
      ),data: body);
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(TAddCategory.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

}
