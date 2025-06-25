import 'package:dio/dio.dart';
import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';

import 'package:final_poject_sw_engineering/model/user_complaint.dart';

import '../../../app/app_constatns.dart';
import '../../dio_exceptions.dart';
import '../../dio_service.dart';
import 'complaint_repo.dart';

class ComplaintRepoImpl  implements ComplaintRepo{
  @override
  Future<BaseApiResponse<UseComplaint>> postUserComplaint({required Map<String, dynamic> body}) async{
    try {
      final response = await DioService.dioService
          .post(AppConstants.complaintEndPoint,data: body);
      if (response.statusCode == 200) {
        return BaseApiResponse.completed(UseComplaint.fromJson(response.data));
      } else {
        return BaseApiResponse.error(response.statusMessage);
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioException(e);
    }
  }
 }

