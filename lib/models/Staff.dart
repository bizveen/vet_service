/// comments : ""
/// id : ""
/// path : ""
/// role : ""
/// userId : ""

class Staff {
  Staff({
      this.comments, 
      this.id, 
      this.path, 
      this.role, 
      this.userId,});

  Staff.fromJson(dynamic json) {
    comments = json['comments'];
    id = json['id'];
    path = json['path'];
    role = json['role'];
    userId = json['userId'];
  }
  String? comments;
  String? id;
  String? path;
  String? role;
  String? userId;
Staff copyWith({  String? comments,
  String? id,
  String? path,
  String? role,
  String? userId,
}) => Staff(  comments: comments ?? this.comments,
  id: id ?? this.id,
  path: path ?? this.path,
  role: role ?? this.role,
  userId: userId ?? this.userId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comments'] = comments;
    map['id'] = id;
    map['path'] = path;
    map['role'] = role;
    map['userId'] = userId;
    return map;
  }

}