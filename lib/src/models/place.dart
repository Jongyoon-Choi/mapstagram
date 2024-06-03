class Place {
  final String? placeTitle;
  final String? mapx;
  final String? mapy;
  final double? avgRating;

  Place({
    required this.placeTitle,
    required this.mapx,
    required this.mapy,
    required this.avgRating,
  });

  // JSON에서 객체를 생성하는 팩토리 메서드
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeTitle: json['placeTitle'],
      mapx: json['mapx'],
      mapy: json['mapy'],
      avgRating: json['avgRating'],
    );
  }

  // 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'placeTitle': placeTitle,
      'mapx': mapx,
      'mapy': mapy,
      'avgRating': avgRating,
    };
  }

  @override
  String toString() {
    return 'Place(placeTitle: $placeTitle, mapx: $mapx, mapy: $mapy, avgRating: $avgRating)';
  }
}
