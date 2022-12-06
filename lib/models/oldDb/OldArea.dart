class OldArea {
  OldArea({
      this.area, 
      this.region, 
      this.subRegion,});

  OldArea.fromJson(dynamic json) {
    area = json['area'];
    region = json['region'];
    subRegion = json['subRegion'];
  }
  String? area;
  String? region;
  String? subRegion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['area'] = area;
    map['region'] = region;
    map['subRegion'] = subRegion;
    return map;
  }

}