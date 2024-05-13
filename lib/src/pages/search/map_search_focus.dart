import 'package:flutter/material.dart';
import 'package:mapstagram/src/controller/bottom_nav_controller.dart';
import 'package:mapstagram/src/pages/search/map_search_result.dart';

class MapSearchFocus extends StatefulWidget {
  const MapSearchFocus({super.key});

  @override
  State<MapSearchFocus> createState() => _MapSearchFocusState();
}

class _MapSearchFocusState extends State<MapSearchFocus> {
  Widget _VisitPlace() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffdedede)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.location_on, color: Colors.grey),
              ),
              Text(
                '숭실 대학교',
                style: TextStyle(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
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
          onTap: BottomNavController.to.willPopAction,
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
              hintText: ' 장소, 주소 검색',
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              isDense: true,
            ),
            onSubmitted: (keyword) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapSearchResult(),
                  settings: RouteSettings(
                    arguments: keyword, // keyword arguments로 전달
                  ),
                ),
              );
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
            _VisitPlace(),
            _VisitPlace(),
            _VisitPlace(),
            _VisitPlace(),
            _VisitPlace(),
          ],
        ),
      ),
    );
  }
}
