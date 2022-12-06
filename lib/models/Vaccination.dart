



import 'package:uuid/uuid.dart';

import '../constants.dart';
import 'Image_model.dart';
import 'Vaccine.dart';
import 'log.dart';


/// givnDate : 45454
/// id : ""
/// nextArvDate : 454454
/// nextDate : 45454
/// nextVaccination : ""
/// path : ""
/// vaccination : {"cost":6556.55,"expDate":4554545,"name":"","price":454.55,"purchassedDate":545454545,"supplier":"","vaccineId":""}

class Vaccination {
  Vaccination({
    this.givenDate,
    this.id,
    this.nextArvDate,
    this.nextDate,
    this.nextVaccination,
    this.path,
    this.givenVaccine,
    this.images,
    this.clientPath,
    this.logList,
    this.reminderStatus,
    required this.petId,
    required this.clientId,
    required this.vaccinationStatus,
    this.oldVaccination = false,
    this.followUpStatus,

  });

  Vaccination.fromJson(dynamic json) {
    givenDate = json['givenDate'] as int;
    clientPath = json['clientPath'];
    id = json['id'];
    nextArvDate = json['nextArvDate'];
    nextDate = json['nextDate'] as int;
    nextVaccination = json['nextVaccination'];
    path = json['path'];
    petId = json['petId'];
    clientId = json['clientId'];
    reminderStatus = json['reminderStatus'];
    oldVaccination = json['oldVaccination'];
    followUpStatus = json['followUpStatus'];

    vaccinationStatus = json['vaccinationStatus'];
    givenVaccine = json['givenVaccine'] != null
        ? Vaccines.fromJson(json['givenVaccine'])
        : null;
    List<ImageModel> _imageModelList = [];
    if (json['images'] != null) {
      Map<dynamic, dynamic> _map = json['images'] as Map<dynamic, dynamic>;

      _map.forEach(
            (key, element) {
          _imageModelList.add(ImageModel.fromJson(element));
        },
      );
    }
images = _imageModelList;
    List<Log> _logList = [];
    if (json['logs'] != null) {
      Map<dynamic, dynamic> _map = json['logs'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _logList.add(Log.fromJson(map : element));
        },
      );
      logList = _logList;
    }
  }

  int? givenDate;
  String? id;
  String? petId;
  String? clientId;
  String? clientPath;
  int? vaccinationStatus;

  int? nextArvDate;
  int? nextDate;
  String? nextVaccination;

  List<ImageModel?>? images;
  String? path;
  Vaccines? givenVaccine;
  String? reminderStatus;
  List<Log?>? logList;
  bool? oldVaccination;
      String? followUpStatus;

  Vaccination copyWith({
    int? givenDate,
    String? id,
    List<Log?>? logList,
    int? nextArvDate,
    String? clientPath,
    int? nextDate,
    String? petId,
    String? clientId,
    String? nextVaccination,
    List<ImageModel?>? images,
    String? path,
    String? reminderStatus,
    Vaccines? givenVacccine,
    int? vaccinationStatus,
    bool? oldVaccination,
    String? followUpStatus,
  }) =>
      Vaccination(
        givenDate: givenDate ?? this.givenDate,
        id: id ?? this.id,
        logList: logList ?? this.logList,
        clientPath: clientPath ?? this.clientPath,
        nextArvDate: nextArvDate ?? this.nextArvDate,
        nextDate: nextDate ?? this.nextDate,
        images: images ?? this.images,
        petId: petId ?? this.petId,
        clientId: clientId ?? this.clientId,
        nextVaccination: nextVaccination ?? this.nextVaccination,
        path: path ?? this.path,
        reminderStatus: reminderStatus ?? this.reminderStatus,
        givenVaccine: givenVacccine ?? givenVaccine,
        vaccinationStatus: vaccinationStatus ?? this.vaccinationStatus,
        followUpStatus: followUpStatus ?? this.followUpStatus,
        oldVaccination: oldVaccination ?? this.oldVaccination
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['givenDate'] = givenDate;
    map['clientPath'] = clientPath;
    map['id'] = id.toString();
    map['petId'] = petId.toString();
    map['clientId'] = clientId.toString();
    map['nextArvDate'] = nextArvDate;
    map['nextDate'] = nextDate;
    map['nextVaccination'] = nextVaccination;
    map['reminderStatus'] = reminderStatus;
    map['vaccinationStatus'] = vaccinationStatus;
    map['oldVaccination'] = oldVaccination;
    map['followUpStatus'] = followUpStatus;
    map['path'] = path;
    if (givenVaccine != null) {
      map['givenVaccine'] = givenVaccine?.toJson();
    }
    if (givenVaccine != null) {
      if(images!=null){
      Map<String, dynamic>imagesMap  ={};
      images!.forEach((element) {
        imagesMap[Uuid().v1()] = element!.toJson();
      });
      map['images'] = imagesMap;}
    }
    return map;
  }
}
