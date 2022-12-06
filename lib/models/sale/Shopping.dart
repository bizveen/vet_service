/// id : "sdass"

class Shopping {
  Shopping({
      this.id,});

  Shopping.fromJson(dynamic json) {
    id = json['id'];
  }
  String? id;
Shopping copyWith({  String? id,
}) => Shopping(  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    return map;
  }

}