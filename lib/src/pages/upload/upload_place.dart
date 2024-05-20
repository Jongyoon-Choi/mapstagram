import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/controller/upload_controller.dart';
import 'package:mapstagram/src/pages/upload/upload_place_result.dart';

class UploadPlace extends GetView<UploadController> {
  const UploadPlace({super.key});

  Widget _VisitPlace(String title) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffdedede)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.location_on, color: Colors.grey),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Row(
            children: [
              Text(
                '05.12.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.clear, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.west),
          ),
        ),
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffefefef),
          ),
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '장소 검색',
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              isDense: true,
            ),
            onSubmitted: (keyword) {
              Get.to(const UploadPlaceResult(), arguments: keyword);
            },
          ),
        ),
      ),
      //회색 구분 선 하나 추가 예정
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '최근 검색',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _VisitPlace('숭실대'),
            _VisitPlace('동작구 맛집'),
            _VisitPlace('성수동 카페'),
            _VisitPlace('서울 명소'),
          ],
        ),
      ),
    );
  }
}
