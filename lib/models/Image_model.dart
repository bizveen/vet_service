import 'dart:typed_data';

import 'package:uuid/uuid.dart';
import 'package:vet_service/resources/firebase_storage_methods.dart';

/// downloadUrl : ""
/// id : ""
/// path : ""
/// storagePath : ""

class ImageModel {
  ImageModel({
      this.downloadUrl, 
      this.id, 
      this.paths,
      this.storagePath,
    this.title,
    this.date,
     this.image,
    required this.fileType
  });

  ImageModel.fromJson(dynamic json) {
    downloadUrl = json['downloadUrl'];
    id = json['id'];
    if(json['paths']!= null){
      Map<dynamic, dynamic> map = json['path'] as Map<dynamic, dynamic>;
      map.forEach((key, value) { paths!.add( value['path']);});
    }

    storagePath = json['storagePath'];
    title = json['title'];
    date = json['date'];
    fileType = json['fileType'];

  }
  String? downloadUrl;
  int? fileType;
  String? id;
  List<String?>? paths;
  String? storagePath;
  String? title;
  String? date;
  Uint8List? image;
ImageModel copyWith({  String? downloadUrl,
  String? id,
  int? fileType,
  List<String?>? paths,
  String? storagePath,
  String? title,
  String? date,
}) => ImageModel(  downloadUrl: downloadUrl ?? this.downloadUrl,
  id: id ?? this.id,
  paths: paths ?? this.paths,
  storagePath: storagePath ?? this.storagePath,
  date: date ?? this.date,
  title: title ?? this.title,
  fileType:  fileType ?? this.fileType
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final pathMap = <String, dynamic>{};
    map['downloadUrl'] = downloadUrl;
    map['id'] = id;
    if(paths != null){
      for (var element in paths!) { pathMap[const Uuid().v1()] = {'path' :  element}; }

    }
    map['path'] = paths;
    map['storagePath'] = storagePath;
    map['title'] = title;
    map['date'] = date;
    map['fileType'] = fileType;



    return map;
  }

}