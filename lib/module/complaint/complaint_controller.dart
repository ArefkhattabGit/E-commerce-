import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/api/repo/complaintRepo/complaint_repo_Impl.dart';
import 'package:final_poject_sw_engineering/base/base_getx_controller.dart';
import 'package:final_poject_sw_engineering/model/user_complaint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintController extends BaseGetxController {
  ComplaintRepoImpl complaintRepoImpl = ComplaintRepoImpl();

  final TextEditingController descriptionController = TextEditingController();

  BaseApiResponse<UseComplaint>? userComplaint;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  postUserComplaint() async {
    setLoading(true);

    userComplaint = await complaintRepoImpl.postUserComplaint(
        body: {'description': descriptionController.text.trim()});

    setLoading(false);
    Get.back();
    Get.snackbar("Complaint Sent", "We have received your complaint.",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    descriptionController.clear();
  }
}
