import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/model/user_profile.dart';

abstract class ProfileRepo {
  Future<BaseApiResponse<UserProfile>> getUserProfile();
  Future<BaseApiResponse> postUpdateUserProfile({required int id ,required Map<String,dynamic> body});
}
