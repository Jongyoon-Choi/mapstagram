import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MapSearchController extends GetxController
    with GetTickerProviderStateMixin {
  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // 권한이 허용됨
    } else if (status.isDenied) {
      // 권한이 거부됨
    } else if (status.isPermanentlyDenied) {
      // 권한이 영구적으로 거부됨
      openAppSettings();
    }
  }
}
