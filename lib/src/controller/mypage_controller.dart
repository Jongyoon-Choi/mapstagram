import 'package:flutter/material.dart';
import 'package:mapstagram/src/controller/auth_controller.dart';
import 'package:mapstagram/src/models/instagram_user.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/models/post.dart';
import 'package:mapstagram/src/repository/post_repository.dart';

import '../notification/local_push_notification.dart';

class MypageController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;
  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    loadData();

    //listen notification
    listenNotifications();
  }

  //푸시 알림 스트림에 데이터를 리슨
  void listenNotifications() {
    LocalPushNotifications.notificationStream.stream.listen((String? payload) {
      if (payload != null) {
        print('Received payload: $payload');
        //Navigator.pushNamed(context, '/message', arguments: payload);
      }
    });
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
