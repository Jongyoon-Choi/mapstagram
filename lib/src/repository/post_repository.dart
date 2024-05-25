import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mapstagram/src/models/post.dart';

class PostRepository {
  static Future<void> updatePost(Post postData) async {
    await FirebaseFirestore.instance.collection('post').add(postData.toMap());
  }

  static Future<List<Post>> loadFeedList() async {
    var document = FirebaseFirestore.instance
        .collection('post')
        .orderBy('createdAt', descending: true)
        .limit(20);
    var data = await document.get();
    return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
  }

  static Future<List<Post>> loadMyFeedList(String myUid) async {
    try {
      // var querySnapshot =
      //     await FirebaseFirestore.instance.collection('post').limit(1).get();
      // print("userInfo : " + querySnapshot.docs.first.data()['userInfo']['uid']);
      var document = FirebaseFirestore.instance
          .collection('post')
          .where('userInfo.uid', isEqualTo: myUid)
          .orderBy('createdAt', descending: true)
          .limit(20);

      var data = await document.get();
      return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
    } catch (e) {
      print('Error loading my feed list: $e');
      return [];
    }
  }
}
