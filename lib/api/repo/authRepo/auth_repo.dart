import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/model/register_model.dart';

import '../../../model/login_model.dart';

abstract class AuthRepo{
  Future<BaseApiResponse<RegisterModel>> postUserRegister({required Map<String,dynamic> body});
  Future<BaseApiResponse<LoginModel>> postUserLogin({required Map<String,dynamic> body});
}