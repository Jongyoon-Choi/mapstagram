import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mapstagram/src/models/post.dart';
import 'package:mapstagram/src/pages/search/search_focus.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/repository/post_repository.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  RxList<Post> postList = <Post>[].obs;

  @override
  void initState() {
    super.initState();
    _loadFeedList();
  }

  Future<void> _loadFeedList() async {
    var feedList = await PostRepository.loadFeedList();
    postList.assignAll(feedList);
  }

  Widget _appbar() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              //Get.to(SearchFocus());
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchFocus()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xffefefef),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  Text(
                    '검색',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff838383),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return Obx(
      () => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: postList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _postCard(postList[index]);
        },
      ),
    );
  }

  Widget _postCard(Post post) {
    return Container(
      height: Get.width * 0.33,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: CachedNetworkImage(
        imageUrl: post.thumbnail!,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _loadFeedList();
          },
          child: ListView(
            children: [
              _appbar(),
              Expanded(child: _body()),
            ],
          ),
        ),
      ),
    );
  }
}
