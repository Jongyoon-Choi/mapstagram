import 'package:flutter/material.dart';
import 'package:mapstagram/src/components/avatar_widget.dart';
import 'package:mapstagram/src/components/image_data.dart';
import 'package:mapstagram/src/components/post_widget.dart';
import 'package:mapstagram/src/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/pages/active_history.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  Widget _myStory() {
    return Stack(
      children: [
        AvartarWidget(
          type: AvatarType.TYPE2,
          thumbPath:
              'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg',
          size: 70,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(color: Colors.white, width: 2)),
            child: const Center(
              child: Text(
                '+',
                style:
                    TextStyle(fontSize: 20, color: Colors.white, height: 1.1),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        const SizedBox(width: 20),
        _myStory(),
        const SizedBox(width: 5),
        ...List.generate(
          100,
          (index) => AvartarWidget(
            type: AvatarType.TYPE1,
            thumbPath:
                'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg',
          ),
        ),
      ]),
    );
  }

  Widget _postList() {
    return Obx(
      () => Column(
        children: List.generate(controller.postList.length,
            (index) => PostWidget(post: controller.postList[index])).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'mapstagram',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(const ActiveHistory());
            },
            child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.favorite_border)),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.loadFeedList();
        },
        child: ListView(
          children: [
            _storyBoardList(),
            _postList(),
          ],
        ),
      ),
    );
  }
}
