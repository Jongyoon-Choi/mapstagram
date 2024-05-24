import 'package:mapstagram/src/models/post.dart';
import 'package:mapstagram/src/repository/post_repository.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFeedList();
    _checkPermission();
  }

  void loadFeedList() async {
    var feedList = await PostRepository.loadFeedList();
    postList.assignAll(feedList);
  }

  void _checkPermission() {
    Permission.location.request().then((status) {
      if (status.isGranted) {
        print('위치 권한: 성공');
      } else {
        print('위치 권한: 실패');
      }
    });
  }
}
