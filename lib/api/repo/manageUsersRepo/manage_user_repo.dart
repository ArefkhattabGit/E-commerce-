import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/model/TManageUsers.dart';
import 'package:final_poject_sw_engineering/model/TUserStatus.dart';

import '../../../model/TAddCategory.dart';

abstract class AdminManageRepo {
  Future<BaseApiResponse<TManageUsers>> getAdminAllUsers({Map<String, dynamic>? query});

  Future<BaseApiResponse<TUserStatus>> postChangeUserStatus({required int id, required Map<String, dynamic> body});
  Future<BaseApiResponse> deleteRemoveUser({required int id});
  Future<BaseApiResponse<TAddCategory>> postAddAdminCategory({Map<String,dynamic> body});

}
