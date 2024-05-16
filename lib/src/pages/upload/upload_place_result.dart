import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class UploadPlaceResult extends StatelessWidget {
  const UploadPlaceResult({super.key});

  Future<List<Map<String, String>>> _SearchKeyword(String text) async {
    final encodedText = Uri.encodeComponent(text); // text를 URL 인코딩합니다.
    final url = Uri.parse(
        'https://openapi.naver.com/v1/search/local.xml?query=$encodedText&display=5&start=1&sort=comment');
    final headers = {
      'X-Naver-Client-Id': 'HfLbhOX0mk6W6DBlMWNU',
      'X-Naver-Client-Secret': 'EQFNwLhm2n',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // XML 문자열을 파싱합니다.
      var document = xml.XmlDocument.parse(response.body);

      // 파싱된 결과를 저장할 리스트를 초기화합니다.
      List<Map<String, String>> resultList = [];

      // 각 <item> 요소를 반복하여 필요한 정보를 추출합니다.
      for (var item in document.findAllElements('item')) {
        // 각 요소에서 필요한 정보를 추출합니다.
        var title = item.findElements('title').single.innerText;
        // <b> 태그를 제거합니다.
        title = title.replaceAll('<b>', '').replaceAll('</b>', '');
        var roadAddress = item.findElements('roadAddress').single.innerText;
        var mapx = item.findElements('mapx').single.innerText;
        var mapy = item.findElements('mapy').single.innerText;

        // 추출한 정보를 맵에 저장하고 결과 리스트에 추가합니다.
        var resultMap = {
          'title': title,
          'roadAddress': roadAddress,
          'mapx': mapx,
          'mapy': mapy,
        };
        resultList.add(resultMap);
      }
      print('resultList: ${resultList}');
      return resultList;
    } else {
      throw Exception('Failed to search keyword: ${response.statusCode}');
    }
  }

  Widget PlaceItem(Map<String, String> item) {
    final title = item['title'];
    final roadAddress = item['roadAddress'];

    return Container(
      padding: const EdgeInsets.all(15),
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
          const SizedBox(height: 8),
          ElevatedButton(
              onPressed: () {
                Get.back(result: item);
              },
              child: const Text('선택')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var keyword = Get.arguments;

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
