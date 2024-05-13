import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mapstagram/src/components/image_data.dart';
import 'package:mapstagram/src/controller/upload_controller.dart';
import 'package:get/get.dart';

class UploadPlace extends GetView<UploadController> {
  const UploadPlace({super.key});

  @override
  Widget build(BuildContext context) {
    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.west),
          ),
        ),
        title: const Text(
          '장소 선택',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: controller.gotoDescription,
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.east, color: Colors.blue),
            ),
          )
        ],
      ),
      body: NaverMap(
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
              position: const NLatLng(37.56661381925933, 126.97839497849134));
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
      ),
    );
  }
}
