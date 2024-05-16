import 'package:mapstagram/src/models/instagram_user.dart';

class Post {
  final String? id;
  final String? thumbnail;
  final String? description;
  final String? placeTitle;
  final String? roadAddress;
  final String? mapx;
  final String? mapy;
  final double? rating;
  final int? likeCount;
  final IUser? userInfo;
  final String? uid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  //userInfo와 겹치는 정보들이 있고 update 됐을 때 Post의 변수들은 변경되지 않는 문제가 존재
  Post({
    this.id,
    this.thumbnail,
    this.description,
    this.placeTitle,
    this.roadAddress,
    this.mapx,
    this.mapy,
    this.rating,
    this.likeCount,
    this.userInfo,
    this.uid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  static Post? init(IUser userInfo) {
    var time = DateTime.now();
    return Post(
      thumbnail: '',
      userInfo: userInfo,
      uid: userInfo.uid,
      description: '',
      placeTitle: '',
      roadAddress: '',
      mapx: '',
      mapy: '',
      rating: 0.0,
      createdAt: time,
      updatedAt: time,
    );
  }

  factory Post.fromJson(String docId, Map<String, dynamic> json) {
    return Post(
      id: json['id'] == null ? '' : json['id'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      placeTitle:
          json['placeTitle'] == null ? '' : json['placeTitle'] as String,
      roadAddress:
          json['roadAddress'] == null ? '' : json['roadAddress'] as String,
      mapx: json['mapx'] == null ? '' : json['mapx'] as String,
      mapy: json['mapy'] == null ? '' : json['mapy'] as String,
      rating: json['rating'] == null ? 0.0 : json['rating'],
      likeCount: json['likeCount'] == null ? 0 : json['likeCount'] as int,
      userInfo:
          json['userInfo'] == null ? null : IUser.fromJson(json['userInfo']),
      uid: json['uid'] == null ? '' : json['uid'] as String,
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : json['createdAt'].toDate(),
      updatedAt: json['updatedAt'] == null
          ? DateTime.now()
          : json['updatedAt'].toDate(),
      deletedAt: json['deletedAt'] == null ? null : json['deletedAt'].toDate(),
    );
  }

  Post copyWith({
    String? id,
    String? thumbnail,
    String? description,
    String? placeTitle,
    String? roadAddress,
    String? mapx,
    String? mapy,
    double? rating,
    int? likeCount,
    IUser? userInfo,
    String? uid,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Post(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      placeTitle: placeTitle ?? this.placeTitle,
      roadAddress: roadAddress ?? this.roadAddress,
      mapx: mapx ?? this.mapx,
      mapy: mapy ?? this.mapy,
      rating: rating ?? this.rating,
      likeCount: likeCount ?? this.likeCount,
      userInfo: userInfo ?? this.userInfo,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'description': description,
      'placeTitle': placeTitle,
      'roadAddress': roadAddress,
      'mapx': mapx,
      'mapy': mapy,
      'rating': rating,
      'likeCount': likeCount,
      'userInfo': userInfo!.toMap(),
      'uid': uid,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}
