/// address : ""
/// contacts : ""
/// id : ""
/// name : ""
/// path : ""

class Supplier {
  Supplier({
      this.address, 
      this.contacts, 
      this.id, 
      this.name, 
      this.path,});

  Supplier.fromJson(dynamic json) {
    address = json['address'];
    contacts = json['contacts'];
    id = json['id'];
    name = json['name'];
    path = json['path'];
  }
  String? address;
  String? contacts;
  String? id;
  String? name;
  String? path;
Supplier copyWith({  String? address,
  String? contacts,
  String? id,
  String? name,
  String? path,
}) => Supplier(  address: address ?? this.address,
  contacts: contacts ?? this.contacts,
  id: id ?? this.id,
  name: name ?? this.name,
  path: path ?? this.path,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['contacts'] = contacts;
    map['id'] = id;
    map['name'] = name;
    map['path'] = path;
    return map;
  }

}