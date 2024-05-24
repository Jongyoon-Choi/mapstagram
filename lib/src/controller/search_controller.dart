import 'package:mapstagram/src/models/post.dart';
import 'package:mapstagram/src/repository/post_repository.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFeedList();
  }

  void loadFeedList() async {
    var feedList = await PostRepository.loadFeedList();
    postList.assignAll(feedList);
  }
}
