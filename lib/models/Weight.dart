import 'package:string_extensions/string_extensions.dart';

/// comment : ""
/// date : 4545
/// weight : 45.3

class Weight {
  Weight({
      this.comment, 
      this.date, 
      this.weight,
  this.id});

  Weight.fromJson(dynamic json) {
    comment = json['comment'];
    date = json['date'];
    weight = json['weight'];
    // = double.parse(tmpWeight.toString().isNumber ? tmpWeight : '0' );
    id = json['id'];
  }
  String? id;
  String? comment;
  int? date;
  String? weight;
Weight copyWith({  String? comment,
  int? date,
  String? weight,
  String? id,
}) => Weight(  comment: comment ?? this.comment,
  date: date ?? this.date,
  weight: weight ?? this.weight,
  id: id?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comment'] = comment;
    map['date'] = date;
    map['weight'] = weight;
    map['id'] = id;
    return map;
  }

  Duration getAge(DateTime birthDay){
    return DateTime.fromMicrosecondsSinceEpoch(date!).difference(birthDay);
  }
}