import 'package:flutter/material.dart';
// import 'package:mapstagram/src/pages/active_history.dart';
import 'package:mapstagram/src/pages/home.dart';
import 'package:mapstagram/src/pages/map_search.dart';
import 'package:mapstagram/src/pages/mypage.dart';
import 'package:mapstagram/src/pages/search.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/components/image_data.dart';
import 'package:mapstagram/src/controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              const Home(),
              Navigator(
                key: controller.searchPageNavigationKey,
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => const Search(),
                  );
                },
              ),
              Container(),
              Navigator(
                key: controller.mapSearchPageNavigationKey,
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => const MapSearch(),
                  );
                },
              ),
              const MyPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            elevation: 0,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.homeOff),
                activeIcon: ImageData(IconsPath.homeOn),
                label: 'home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.black),
                activeIcon: Icon(Icons.search, color: Colors.black),
                label: 'search',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined, color: Colors.black),
                label: 'add',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined, color: Colors.black),
                activeIcon: Icon(Icons.map, color: Colors.black),
                label: 'map',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, color: Colors.black),
                activeIcon: Icon(Icons.person, color: Colors.black),
                label: 'profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
