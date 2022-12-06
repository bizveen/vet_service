/// group : ""
/// id : ""
/// name : ""
/// path : ""

class Disease {
  Disease({
      this.group, 
      this.id, 
      this.name, 
      this.path,});

  Disease.fromJson(dynamic json) {
    group = json['group'];
    id = json['id'];
    name = json['name'];
    path = json['path'];
  }
  String? group;
  String? id;
  String? name;
  String? path;
Disease copyWith({  String? group,
  String? id,
  String? name,
  String? path,
}) => Disease(  group: group ?? this.group,
  id: id ?? this.id,
  name: name ?? this.name,
  path: path ?? this.path,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['group'] = group;
    map['id'] = id;
    map['name'] = name;
    map['path'] = path;
    return map;
  }

}