/// comment : "asds"
/// id : "cvcvcxvc"
/// name : "TF"
/// path : "cxvvxcvc"

class DifferentialDiagnosis {
  DifferentialDiagnosis({
      this.comment, 
      this.id, 
      this.name, 
      this.path,
    this.order,

  });

  DifferentialDiagnosis.fromJson(dynamic json) {
    comment = json['comment'];
    id = json['id'];
    name = json['name'];
    order = json['order'];

  }
  String? comment;
  String? id;
  String? name;
  String? path;
  int? order;
DifferentialDiagnosis copyWith({  String? comment,
  String? id,
  String? name,
  String? path,
  int? order,
}) => DifferentialDiagnosis(  comment: comment ?? this.comment,
  id: id ?? this.id,
  name: name ?? this.name,
  path: path ?? this.path,
  order: order?? this.order,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comment'] = comment;
    map['id'] = id;
    map['name'] = name;
    map['path'] = path;
    map['order'] = order;

    return map;
  }

}