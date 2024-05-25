import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mapstagram/src/binding/init_bindings.dart';
import 'package:mapstagram/src/models/instagram_user.dart';
import 'package:mapstagram/src/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<IUser> user = IUser().obs;

  @override
  void onInit() {
    super.onInit();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.notification,
    ].request();
    if (statuses[Permission.location]!.isGranted) {
      print('위치 권한: 성공');
    } else {
      print('위치 권한: 실패');
    }
    if (statuses[Permission.notification]!.isGranted) {
      print('알림 권한: 성공');
    } else {
      print('알림 권한: 실패');
    }
  }

  Future<IUser?> loginUser(String uid) async {
    //DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    if (userData != null) {
      user(userData);
      Initbinding.additionalBinging();
    }
    return userData;
  }

  void signup(IUser signupUser, XFile? thumbnail) async {
    if (thumbnail == null) {
      _submitSignup(signupUser);
    } else {
      var task = uploadXFile(thumbnail,
          '${signupUser.uid}/profile.${thumbnail.path.split('.').last}');
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var UpdatedUserData = signupUser.copyWith(thumbnail: downloadUrl);
          _submitSignup(UpdatedUserData);
        }
      });
    }
  }

  UploadTask uploadXFile(XFile file, String filename) {
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    return ref.putFile(f, metadata);
    //users/{uid}/profile.jpg or png...etc
  }

  void _submitSignup(IUser signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if (result) {
      loginUser(signupUser.uid!);
    }
  }
}
