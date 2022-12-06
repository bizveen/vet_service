import 'package:equatable/equatable.dart';

/// cost : ""
/// descriotion : ""
/// id : ""
/// name : ""
/// path : ""
/// retailPrice : ""
/// supplier : ""

class Vaccines  extends Equatable{
  Vaccines({
      this.cost, 
      this.description,
      this.id, 
      this.name, 
      this.path, 
      this.retailPrice, 
      this.supplier,});

  Vaccines.fromJson(dynamic json) {
    cost = json['cost'].toString();
    description = json['description'];
    id = json['id'];
    name = json['name'];
    path = json['path'];
    retailPrice = json['retailPrice'].toString();
    supplier = json['supplier'];
  }
  String? cost;
  String? description;
  String? id;
  String? name;
  String? path;
  String? retailPrice;
  String? supplier;
Vaccines copyWith({  String? cost,
  String? description,
  String? id,
  String? name,
  String? path,
  String? retailPrice,
  String? supplier,
}) => Vaccines(  cost: cost ?? this.cost,
  description: description ?? this.description,
  id: id ?? this.id,
  name: name ?? this.name,
  path: path ?? this.path,
  retailPrice: retailPrice ?? this.retailPrice,
  supplier: supplier ?? this.supplier,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cost'] = cost;
    map['description'] = description;
    map['id'] = id;
    map['name'] = name;
    map['path'] = path;
    map['retailPrice'] = retailPrice;
    map['supplier'] = supplier;
    return map;
  }

  @override

  List<Object?> get props => [name];

}