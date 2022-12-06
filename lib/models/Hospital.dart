import 'Staff.dart';

/// address : ""
/// contacts : ""
/// id : ""
/// path : ""
/// staff : {"comments":"","id":"","path":"","role":"","userId":""}

class Hospital {
  String? address;
  String? contacts;
  String? id;
  String? path;
  List<Staff?>? staff;
  Hospital({
      this.address, 
      this.contacts, 
      this.id, 
      this.path, 
      this.staff,});

  Hospital.fromJson(dynamic json) {
    List<Staff> _staffList = [];
    if (json['staff'] != null) {
      Map<dynamic, dynamic> _map = json['staff'] as Map<dynamic, dynamic>;

      _map.forEach(
            (key, element) {
          _staffList.add(Staff.fromJson(element));
        },
      );
    }
    address = json['address'];
    contacts = json['contacts'];
    id = json['id'];
    path = json['path'];
    staff = _staffList;
  }

Hospital copyWith({  String? address,
  String? contacts,
  String? id,
  String? path,
  List<Staff?>? staff,
}) => Hospital(  address: address ?? this.address,
  contacts: contacts ?? this.contacts,
  id: id ?? this.id,
  path: path ?? this.path,
  staff: staff ?? this.staff,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['contacts'] = contacts;
    map['id'] = id;
    map['path'] = path;
    return map;
  }

}