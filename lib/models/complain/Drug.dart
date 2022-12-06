import 'package:equatable/equatable.dart';

/// comment : "dfsds"
/// doze : "vxcv"
/// id : "dfsdf"
/// name : "Amox"
/// path : "dsfsd"

class Drug extends Equatable {
  Drug({
      this.comment, 
      this.doze, 
      this.id, 
      this.name, 
      this.path,});

  Drug.fromJson(dynamic json) {
    comment = json['comment'];
    doze = json['doze'];
    id = json['id'];
    name = json['name'];
    path = json['path'];
  }
  String? comment;
  String? doze;
  String? id;
  String? name;
  String? path;
Drug copyWith({  String? comment,
  String? doze,
  String? id,
  String? name,
  String? path,
}) => Drug(  comment: comment ?? this.comment,
  doze: doze ?? this.doze,
  id: id ?? this.id,
  name: name ?? this.name,
  path: path ?? this.path,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comment'] = comment;
    map['doze'] = doze;
    map['id'] = id;
    map['name'] = name;
    map['path'] = path;
    return map;
  }

  @override

  List<Object?> get props => [name];

}