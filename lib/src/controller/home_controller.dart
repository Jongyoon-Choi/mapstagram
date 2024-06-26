import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:mapstagram/src/controller/auth_controller.dart';
import 'package:mapstagram/src/models/post.dart';
import 'package:mapstagram/src/notification/local_push_notification.dart';
import 'package:mapstagram/src/repository/post_repository.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxList<Post> postList = <Post>[].obs;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    loadFeedList();
    noti_timer();
  }

  bool checkResidence(Position cur) {
    var user = AuthController.to.user.value;

    var uid = user.uid;

    var diff = NLatLng(double.parse(user.mapx!), double.parse(user.mapy!))
        .distanceTo(NLatLng(cur.latitude, cur.longitude));

    if (diff < 500)
      return true;
    else
      return false;
  }

  bool checkEnoughFar(
      Position pre30, Position pre20, Position pre10, Position cur) {
    var diff30 = NLatLng(pre30.latitude, pre30.longitude)
        .distanceTo(NLatLng(cur.latitude, cur.longitude));
    var diff20 = NLatLng(pre20.latitude, pre20.longitude)
        .distanceTo(NLatLng(cur.latitude, cur.longitude));
    var diff10 = NLatLng(pre10.latitude, pre10.longitude)
        .distanceTo(NLatLng(cur.latitude, cur.longitude));

    if (diff10 < 500 && diff20 < 500 && diff30 >= 500)
      return true;
    else
      return false;
  }

  void noti_timer() async {
    await LocalPushNotifications.init();
    Position pre30 = await Geolocator.getCurrentPosition();
    Position pre20 = await Geolocator.getCurrentPosition();
    Position pre10 = await Geolocator.getCurrentPosition();
    Position cur = await Geolocator.getCurrentPosition();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      //_getCurrentLocation(); // 10분마다 위치를 갱신합니다.

      pre30 = pre20;
      pre20 = pre10;
      pre10 = cur;
      cur = await Geolocator.getCurrentPosition();

      if (!checkResidence(cur) && checkEnoughFar(pre30, pre20, pre10, cur)) {
        /*게시물 처리*/
        var feedList = await PostRepository.loadFeedList();
        double min_diff = 2e9;
        var recommand_post;
        for (int i = 0; i < feedList.length; i++) {
          var diff = NLatLng(double.parse(feedList[i].mapx!),
                  double.parse(feedList[i].mapy!))
              .distanceTo(NLatLng(cur.latitude, cur.longitude));

          if (min_diff > diff) {
            min_diff = diff;
            recommand_post = feedList[i];
          }
        }

        LocalPushNotifications.showSimpleNotification(
            title:
                "${recommand_post.placeTitle} ★${recommand_post.rating.toStringAsFixed(1)}",
            body: "친구들이 다녀간 이 장소를 방문해주세요.",
            payload: "payload");
      }
    });
  }

  void loadFeedList() async {
    var feedList = await PostRepository.loadFeedList();
    postList.assignAll(feedList);
  }

  Future<void> _checkPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.notification,
    ].request();
    if (statuses[Permission.location]!.isGranted) {
      print('위치 권한: 성공');
    } else {
      print('위치 권한: 실패');
    }
    if (statuses[Permission.notification]!.isGranted) {
      print('알림 권한: 성공');
    } else {
      print('알림 권한: 실패');
    }
  }
}
