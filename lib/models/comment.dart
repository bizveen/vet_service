/// comment : ""
/// date : ""
/// id : ""
/// path : ""

class Comment {
  Comment({
      this.comment, 
      this.date, 
      this.id, 
      this.path,});

  Comment.fromJson(dynamic json) {
    comment = json['comment'];
    date = json['date'];
    id = json['id'];
    path = json['path'];
  }
  String? comment;
  String? date;
  String? id;
  String? path;
Comment copyWith({  String? comment,
  String? date,
  String? id,
  String? path,
}) => Comment(  comment: comment ?? this.comment,
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