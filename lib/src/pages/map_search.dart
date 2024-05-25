import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/models/post.dart';
import 'package:mapstagram/src/pages/search/map_search_focus.dart';
import 'package:mapstagram/src/repository/post_repository.dart';

class MapSearch extends StatefulWidget {
  const MapSearch({super.key});

  @override
  State<MapSearch> createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapSearchFocus()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  Text(
                    ' 장소, 주소 검색',
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
    return NaverMap(
      options: const NaverMapViewOptions(
        indoorEnable: true, // 실내 맵 사용 가능 여부 설정
        activeLayerGroups: [
          NLayerGroup.building,
          NLayerGroup.transit
        ], // 표시할 정보 (건물, 대중교통)
        locationButtonEnable: true, // 현위치 버튼 표시 여부 설정
        consumeSymbolTapEvents: false, // 심볼 탭 이벤트 소비 여부 설정
      ),
      onMapReady: (controller) async {
        for (var post in postList) {
          final marker = NMarker(
            id: post.id.toString(), // 고유 id 사용
            position: NLatLng(double.parse(post.mapx.toString()),
                double.parse(post.mapy.toString())),
          );
          final onMarkerInfoWindow = NInfoWindow.onMarker(
            id: marker.info.id,
            text: "${post.placeTitle} (${post.rating})",
          );
          controller.addOverlay(marker);
          marker.openInfoWindow(onMarkerInfoWindow);
        }
        debugPrint("test");
      },
      onMapTapped: (point, latLng) {
        debugPrint("${latLng.latitude}、${latLng.longitude}");
      },
      onSymbolTapped: (symbol) {
        debugPrint(symbol.caption);
      },
      onCameraChange: (position, reason) {},
      onCameraIdle: () {},
      onSelectedIndoorChanged: (indoor) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _body(), // 지도
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _appbar(), // AppBar
            ),
          ],
        ),
      ),
    );
  }
}
