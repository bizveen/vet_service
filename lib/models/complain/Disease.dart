/// id : "fgfg"
/// path : "sdfsdf"

class Disease {
  Disease({
      this.id, 
      this.path,});

  Disease.fromJson(dynamic json) {
    id = json['id'];
    path = json['path'];
  }
  String? id;
  String? path;
Disease copyWith({  String? id,
  String? path,
}) => Disease(  id: id ?? this.id,
  path: path ?? this.path,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['path'] = path;
    return map;
  }

}