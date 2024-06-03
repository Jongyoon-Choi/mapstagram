class IUser {
  String? uid;
  String? nickname;
  String? thumbnail;
  String? description;
  String? address;
  String? addressx;
  String? addressy;
  IUser({
    this.uid,
    this.nickname,
    this.thumbnail,
    this.description,
    this.address,
    this.addressx,
    this.addressy,
  });

  factory IUser.fromJson(Map<String, dynamic> json) {
    return IUser(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      nickname: json['nickname'] == null ? '' : json['nickname'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      address: json['address'] == null ? '' : json['address'] as String,
      addressx: json['addressx'] == null ? '' : json['addressx'] as String,
      addressy: json['addressy'] == null ? '' : json['addressy'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickname': nickname,
      'thumbnail': thumbnail,
      'description': description,
      'address': address,
      'addressx': addressx,
      'addressy': addressy,
    };
  }

  IUser copyWith({
    String? uid,
    String? nickname,
    String? thumbnail,
    String? description,
    String? address,
    String? addressx,
    String? addressy,
  }) {
    return IUser(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      address: address ?? this.address,
      addressx: address ?? this.addressx,
      addressy: address ?? this.addressy,
    );
  }
}
