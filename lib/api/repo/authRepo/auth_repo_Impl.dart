import 'package:dio/dio.dart';
import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';

import 'package:final_poject_sw_engineering/model/login_model.dart';

import '../../../app/app_constatns.dart';
import '../../../model/register_model.dart';
import '../../dio_exceptions.dart';
import '../../dio_service.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<BaseApiResponse<LoginModel>> postUserLogin(
      {required Map<String, dynamic> body}) async {
    try {
      final response = await DioService.dioService
          .post(AppConstants.loginEndPoint, data: body);
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(LoginModel.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse<RegisterModel>> postUserRegister(
      {required Map<String, dynamic> body}) async {
    try {
      final response = await DioService.dioService
          .post(AppConstants.registerEndPoint, data: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return BaseApiResponse.completed(RegisterModel.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }
}
