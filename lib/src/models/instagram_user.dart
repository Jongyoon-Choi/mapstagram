class IUser {
  String? uid;
  String? nickname;
  String? thumbnail;
  String? description;
  String? roadAddress;
  String? mapx;
  String? mapy;
  IUser({
    this.uid,
    this.nickname,
    this.thumbnail,
    this.description,
    this.roadAddress,
    this.mapx,
    this.mapy,
  });

  factory IUser.fromJson(Map<String, dynamic> json) {
    return IUser(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      nickname: json['nickname'] == null ? '' : json['nickname'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      roadAddress:
          json['roadAddress'] == null ? '' : json['roadAddress'] as String,
      mapx: json['mapx'] == null ? '' : json['mapx'] as String,
      mapy: json['mapy'] == null ? '' : json['mapy'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickname': nickname,
      'thumbnail': thumbnail,
      'description': description,
      'roadAddress': roadAddress,
      'mapx': mapx,
      'mapy': mapy,
    };
  }

  IUser copyWith({
    String? uid,
    String? nickname,
    String? thumbnail,
    String? description,
    String? roadAddress,
    String? mapx,
    String? mapy,
  }) {
    return IUser(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      roadAddress: roadAddress ?? this.roadAddress,
      mapx: mapx ?? this.mapx,
      mapy: mapy ?? this.mapy,
    );
  }
}
