import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapstagram/src/controller/bottom_nav_controller.dart';

class MapSearchResult extends StatelessWidget {
  const MapSearchResult({super.key});

  Future<List<Map<String, String>>> _SearchKeyword(String text) async {
    final encodedText = Uri.encodeComponent(text); // text를 URL 인코딩합니다.
    final url = Uri.parse(
        'https://api.vworld.kr/req/search?service=search&request=search&version=2.0&crs=EPSG:900913&bbox=14140071.146077,4494339.6527027,14160071.146077,4496339.6527027&size=10&page=1&query=${encodedText}&type=place&format=json&errorformat=json&key=DB852C75-7547-3DC4-B58B-C419CC2F8C00');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // JSON 문자열을 맵으로 디코딩합니다.
      Map<String, dynamic> data = json.decode(response.body);

      // 필요한 정보를 추출합니다.
      List<Map<String, String>> resultList = [];
      for (var item in data['response']['result']['items']) {
        print('item: ${item}');
        var title = item['title']?.toString() ?? '';
        var roadAddress = item['address']['road']?.toString() ?? '';

        // 추출한 정보를 맵에 저장하고 결과 리스트에 추가합니다.
        var resultMap = {
          'title': title,
          'road': roadAddress,
        };
        resultList.add(resultMap);
      }
      return resultList;
    } else {
      throw Exception('Failed to search keyword: ${response.statusCode}');
    }
  }

  Widget PlaceItem(Map<String, String> item) {
    final title = item['title'];
    final roadAddress = item['road'];

    return Container(
      padding: EdgeInsets.all(15),
      width: Size.infinite.width,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffdedede)),
      ),
      child: Column(
        children: [
          Text(
            title!,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            roadAddress!,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyword = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: BottomNavController.to.willPopAction,
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.west),
          ),
        ),
        titleSpacing: 0,
        title: Text(
          '$keyword 에 대한 검색 결과',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _SearchKeyword(keyword),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final resultList = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: resultList.map((item) => PlaceItem(item)).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
