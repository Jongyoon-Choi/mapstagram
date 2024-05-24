import 'package:mapstagram/src/controller/auth_controller.dart';
import 'package:mapstagram/src/controller/home_controller.dart';
import 'package:mapstagram/src/controller/mypage_controller.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/controller/bottom_nav_controller.dart';

class Initbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }

  static additionalBinging() {
    Get.put(MypageController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}
