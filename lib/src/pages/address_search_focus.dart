import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/controller/auth_controller.dart';
import 'package:mapstagram/src/pages/address_search_result.dart';

class AddressSearchFocus extends GetView<AuthController> {
  const AddressSearchFocus({super.key});

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
              Get.to(const AddressSearchResult(), arguments: keyword);
            },
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                '\n\nTip',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                '아래와 같이 검색하시면\n정확한 검색 결과를 얻을 수 있습니다',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                '\n도로명\n예) 서울시 동작구 상도로 369, 서울시 동작구 보라매로 5길\n\n지역명(동/리) + 번지\n예) 상도동 369\n\n지역명(동/리) + 건물명(아파트명)\n예) 동작 숭실대',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
