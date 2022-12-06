/// comment : ""
/// date : ""
/// id : ""
/// path : ""

class Scannig {
  Scannig({
      this.comment, 
      this.date, 
      this.id, 
      this.path,});

  Scannig.fromJson(dynamic json) {
    comment = json['comment'];
    date = json['date'];
    id = json['id'];
    path = json['path'];
  }
  String? comment;
  String? date;
  String? id;
  String? path;
Scannig copyWith({  String? comment,
  String? date,
  String? id,
  String? path,
}) => Scannig(  comment: comment ?? this.comment,
  date: date ?? this.date,
  id: id ?? this.id,
  path: path ?? this.path,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comment'] = comment;
    map['date'] = date;
    map['id'] = id;
    map['path'] = path;
    return map;
  }

}