import 'package:flutter/material.dart';
import 'package:mapstagram/src/controller/auth_controller.dart';
import 'package:mapstagram/src/models/instagram_user.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/models/post.dart';
import 'package:mapstagram/src/repository/post_repository.dart';

class MypageController extends GetxController with GetTickerProviderStateMixin {
  static MypageController get to => Get.find();
  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;
  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    loadData();
  }

  void setTargetUser() {
    var uid = Get.parameters['targetUid'];
    if (uid == null) {
      targetUser(AuthController.to.user.value);
    } else {
      //상대 uid로 users collection 조회
    }
  }

  void loadData() async {
    setTargetUser();
    var feedList = await PostRepository.loadMyFeedList(targetUser.value.uid!);
    postList.assignAll(feedList);
  }
}
