/// id : ""
/// name : ""
/// path : ""
/// region : ""

class Area {
  Area({
      this.id, 
      this.name, 
      this.path, 
      this.region,});

  Area.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    region = json['region'];
  }
  String? id;
  String? name;
  String? path;
  String? region;
Area copyWith({  String? id,
  String? name,
  String? path,
  String? region,
}) => Area(  id: id ?? this.id,
  name: name ?? this.name,
  path: path ?? this.path,
  region: region ?? this.region,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['path'] = path;
    map['region'] = region;
    return map;
  }

}