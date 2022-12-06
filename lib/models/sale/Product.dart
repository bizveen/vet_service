
import '../Image_model.dart';

/// brand : "sdasd"
/// category : "dfdfs"
/// description : "sdasdas"
/// id : "sadfdsfdf"
/// name : "vcvcvx"
/// path : "dfsdfdsf"
/// supplier : "fsdfsf"

class Product {
  Product({
      this.brand, 
      this.category, 
      this.description, 
      this.id, 
      this.name, 
      this.path, 
      this.supplier,
    this.image,

  });

  Product.fromJson(dynamic json) {
    brand = json['brand'];
    category = json['category'];
    description = json['description'];
    id = json['id'];
    name = json['name'];
    path = json['path'];
    supplier = json['supplier'];
  }
  String? brand;
  String? category;
  String? description;
  String? id;
  String? name;
  String? path;
  String? supplier;
  ImageModel? image;
Product copyWith({  String? brand,
  String? category,
  String? description,
  String? id,
  String? name,
  String? path,
  String? supplier,
  ImageModel? image,
}) => Product(  brand: brand ?? this.brand,
  category: category ?? this.category,
  description: description ?? this.description,
  id: id ?? this.id,
  name: name ?? this.name,
  path: path ?? this.path,
  supplier: supplier ?? this.supplier,
  image: image ?? this.image,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['brand'] = brand;
    map['category'] = category;
    map['description'] = description;
    map['id'] = id;
    map['name'] = name;
    map['path'] = path;
    map['supplier'] = supplier;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    return map;
  }

}