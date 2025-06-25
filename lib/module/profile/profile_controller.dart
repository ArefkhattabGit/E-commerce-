import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/base/base_getx_controller.dart';
import 'package:final_poject_sw_engineering/model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/repo/profileRepo/profile_repo_Impl.dart';

class ProfileController extends BaseGetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  final ProfileRepoImpl _repoImpl = ProfileRepoImpl();
  BaseApiResponse<UserProfile>? tProfile;

  final areaController = TextEditingController();
  final streetController = TextEditingController();
  final buildingController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    getUserProfile();
    super.onInit();
  }

  getUserProfile() async {
    setLoading(true);
    tProfile = await _repoImpl.getUserProfile();

    areaController.text = tProfile?.data?.location.area ?? '';
    streetController.text = tProfile?.data?.location.street ?? '';
    buildingController.text = tProfile?.data?.location.building ?? '';
    emailController.text = tProfile?.data?.email ?? '';

    setLoading(false);
    update();
  }

  saveUserProfile() async {
    await _repoImpl.postUpdateUserProfile(id: tProfile!.data!.id, body: {
      'area': areaController.text,
      'street': streetController.text,
      'building': buildingController.text
    });

    print(
        "Saving... Area: ${areaController.text}, Street: ${streetController.text}, Building: ${buildingController.text}");

    final snackBar = SnackBar(
      content: Text('Success Update Your Profile.'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
   await _repoImpl.getUserProfile();

    }

  @override
  void dispose() {
    areaController.dispose();
    streetController.dispose();
    buildingController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
