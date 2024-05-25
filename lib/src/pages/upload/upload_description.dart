import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mapstagram/src/controller/upload_controller.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/pages/upload/upload_place.dart';

class UploadDescription extends GetView<UploadController> {
  const UploadDescription({super.key});

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.file(
              controller.filteredImage!,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller.textEditingController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '문구 입력...',
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _place() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const UploadPlace());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_pin, color: Colors.lightBlue),
                  const SizedBox(width: 10),
                  Text(
                    controller.placeTitle.value,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rating() {
    return Center(
      child: RatingBar(
        initialRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        ratingWidget: RatingWidget(
          full: const Icon(Icons.star, color: Colors.blue, size: 50),
          half: const Icon(Icons.star_half, color: Colors.blue, size: 50),
          empty: const Icon(Icons.star_border, color: Colors.blue, size: 50),
        ),
        itemPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        onRatingUpdate: (rating) {
          controller.changeRating(rating);
        },
      ),
    );
  }

// Icon(Icons.star_border, color: Colors.blue, size: 40),
  Widget infoOnt(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

  Widget get line => const Divider(color: Colors.grey);

  Widget snsInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Facebook',
                style: TextStyle(fontSize: 17),
              ),
              Switch(value: false, onChanged: (bool value) {})
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Twitter',
                style: TextStyle(fontSize: 17),
              ),
              Switch(value: false, onChanged: (bool value) {})
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tumblr',
                style: TextStyle(fontSize: 17),
              ),
              Switch(value: false, onChanged: (bool value) {})
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.west),
          ),
        ),
        title: const Text(
          '새 게시물',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.blue),
            onPressed: controller.uploadPost,
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: GestureDetector(
              onTap: controller.unfocusKeyboard,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _description(),
                    line,
                    _place(),
                    _rating(),
                    line,
                    infoOnt('사람 태그'),
                    line,
                    infoOnt('위치 추가'),
                    line,
                    infoOnt('음악 추가'),
                    line,
                    snsInfo(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
