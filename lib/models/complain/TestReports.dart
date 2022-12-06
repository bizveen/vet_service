

import '../Image_model.dart';

/// id : "sfdfgd"
/// image : {"id":"xcz","path":"xvxv"}
/// name : "fgdf"

class TestReports {
  TestReports({
    this.id,
    this.image,
    this.name,
  });

  TestReports.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    name = json['name'];
  }

  String? id;
  ImageModel? image;
  String? name;

  TestReports copyWith({
    String? id,
    ImageModel? image,
    String? name,
  }) =>
      TestReports(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['name'] = name;
    return map;
  }
}
