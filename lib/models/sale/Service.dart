/// id : "sdsdasd"

class Service {
  Service({
      this.id,});

  Service.fromJson(dynamic json) {
    id = json['id'];
  }
  String? id;
Service copyWith({  String? id,
}) => Service(  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    return map;
  }

}