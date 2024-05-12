import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mapstagram/src/pages/search/map_search_focus.dart';

class MapSearch extends StatefulWidget {
  const MapSearch({super.key});

  @override
  State<MapSearch> createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {
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
        final marker = NMarker(
            id: 'test',
            position: NLatLng(37.56661381925933, 126.97839497849134));
        final onMarkerInfoWindow =
            NInfoWindow.onMarker(id: marker.info.id, text: "테스트");
        controller.addOverlay(marker);
        marker.openInfoWindow(onMarkerInfoWindow);
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
