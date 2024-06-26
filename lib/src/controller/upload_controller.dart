import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mapstagram/src/components/message_popup.dart';
import 'package:mapstagram/src/controller/auth_controller.dart';
import 'package:mapstagram/src/controller/home_controller.dart';
import 'package:mapstagram/src/controller/mypage_controller.dart';
import 'package:mapstagram/src/models/post.dart';
import 'package:mapstagram/src/pages/upload/upload_description.dart';
import 'package:mapstagram/src/repository/post_repository.dart';
import 'package:mapstagram/src/utils/data_util.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';

class UploadController extends GetxController {
  var albums = <AssetPathEntity>[];
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  RxString headerTitle = ''.obs;
  RxString placeTitle = '장소 추가'.obs;
  TextEditingController textEditingController = TextEditingController();

  Rx<AssetEntity> selectedImage = const AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  Map<String, String>? place;
  double? rating;
  File? filteredImage;
  Post? post;

  @override
  void onInit() {
    super.onInit();
    post = Post.init(AuthController.to.user.value);
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    print(result);
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
          ),
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
      _loadData();
    } else {
      print('실패');
    }
  }

  void _loadData() async {
    changeAlbum(albums.first);
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    changeSelectedImage(imageList.first);
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
  }

  void changeRating(double rating) {
    this.rating = rating;
  }

  void changePlace(Map<String, String> item) {
    place = item;
    placeTitle(item['title']);
  }

  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 600);
    var imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(() => const UploadDescription());
    }
  }

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
    //FocusScope.of(context).unfocus(); Get.context!
  }

  void uploadPost() {
    unfocusKeyboard();
    var filename = DataUtil.makeFilePath();
    var task = uploadFile(
        filteredImage!, '${AuthController.to.user.value.uid}/$filename');
    if (task != null) {
      task.snapshotEvents.listen(
        (event) async {
          if (event.bytesTransferred == event.totalBytes &&
              event.state == TaskState.success) {
            var downloadUrl = await event.ref.getDownloadURL();
            var updatedPost = post!.copyWith(
              thumbnail: downloadUrl,
              description: textEditingController.text,
              placeTitle: place?['title'],
              roadAddress: place?['roadAddress'],
              mapx: place?['mapy'],
              mapy: place?['mapx'],
              rating: rating,
            );
            _submitPost(updatedPost);
            HomeController.to.loadFeedList();
            MypageController.to.loadData();
          }
        },
      );
    }
  }

  UploadTask uploadFile(File file, String filename) {
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    return ref.putFile(file, metadata);
    //users/{uid}/profile.jpg or png...etc
  }

  void _submitPost(Post postData) async {
    await PostRepository.updatePost(postData);
    showDialog(
      context: Get.context!,
      builder: (context) => MessagePopup(
        title: '포스트',
        message: '포스팅이 완료되었습니다.',
        okCallback: () {
          Get.until((route) => Get.currentRoute == '/');
        },
      ),
    );
  }
}
