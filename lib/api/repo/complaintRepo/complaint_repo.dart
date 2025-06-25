import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/model/user_complaint.dart';

abstract class ComplaintRepo {
  Future<BaseApiResponse<UseComplaint>> postUserComplaint({required Map<String,dynamic> body});
}
