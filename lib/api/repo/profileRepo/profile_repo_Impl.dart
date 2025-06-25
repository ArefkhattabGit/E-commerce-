import 'package:dio/dio.dart';
import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/api/repo/profileRepo/profile_repo.dart';
import 'package:final_poject_sw_engineering/model/user_profile.dart';

import '../../../app/app_constatns.dart';
import '../../dio_exceptions.dart';
import '../../dio_service.dart';

class ProfileRepoImpl implements ProfileRepo{
  @override
  Future<BaseApiResponse<UserProfile>> getUserProfile() async{
    try {
      final response = await DioService.dioService.get(AppConstants.userProfileEndPoint);
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(UserProfile.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }

  @override
  Future<BaseApiResponse> postUpdateUserProfile({required int id, required Map<String, dynamic> body}) async{
    try {
      final response = await DioService.dioService.post("${AppConstants.updateProfileEndPoint}/$id",data: body);
      if (response.statusCode == 200) {
        print(response.data);
        return BaseApiResponse.completed(response.data);
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e.toString());
      throw DioExceptions.fromDioException(e);
    }
  }

 }