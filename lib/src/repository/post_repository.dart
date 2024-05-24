import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mapstagram/src/models/post.dart';

class PostRepository {
  static Future<void> updatePost(Post postData) async {
    await FirebaseFirestore.instance.collection('post').add(postData.toMap());
  }

  static Future<List<Post>> loadFeedList() async {
    var documnet = FirebaseFirestore.instance
        .collection('post')
        .orderBy('createdAt', descending: true)
        .limit(20);
    var data = await documnet.get();
    return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
  }
}
