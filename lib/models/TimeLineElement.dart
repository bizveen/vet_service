

import 'Image_model.dart';

/// dateTime : 1
/// description : "dfdsfsdf"
/// id : "sdd"
/// image : "dfsdfs"
/// addedById : "dfsdfs"
/// addedByName : "dfsdfs"

class TimeLineElement {
  TimeLineElement({
      this.dateTime, 
      this.description, 
      this.id, 
      this.images,
      this.addedById, 
      this.addedByName,});

  TimeLineElement.fromJson(dynamic json) {
    dateTime = json['dateTime'];
    description = json['description'];
    id = json['id'];
    List<ImageModel?> _images = [];

    if (json['images'] != null) {
      Map<dynamic, dynamic> _map = json['images'] as Map<dynamic, dynamic>;

      _map.forEach(
            (key, element) {

          _images.add(ImageModel.fromJson(element));
        },
      );

    }
    images = _images;
    addedById = json['addedById'];
    addedByName = json['addedByName'];
  }
  int? dateTime;
  String? description;
  String? id;
  List<ImageModel?>? images;
  String? addedById;
  String? addedByName;
TimeLineElement copyWith({
  int? dateTime,
  String? description,
  String? id,
  List<ImageModel?>? images,
  String? addedById,
  String? addedByName,
}) => TimeLineElement(  dateTime: dateTime ?? this.dateTime,
  description: description ?? this.description,
  id: id ?? this.id,
  images: images ?? this.images,
  addedById: addedById ?? this.addedById,
  addedByName: addedByName ?? this.addedByName,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dateTime'] = dateTime;
    map['description'] = description;
    map['id'] = id;

    map['addedById'] = addedById;
    map['addedByName'] = addedByName;
    if(images != null  && images!.isNotEmpty){
      Map<String , dynamic> imagesMap ={};
      for (var element in images!) { imagesMap[element!.id!] = element.toJson();}
      map['images'] = imagesMap;
    }
    return map;
  }

}