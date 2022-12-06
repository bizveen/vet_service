import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';

import 'Image_model.dart';
import 'PregnancyCycle.dart';
import 'Vaccination.dart';
import 'Weight.dart';
import 'complain/Complain.dart';

/// attention : ""
/// birthDay : ""
/// birthMonth : ""
/// birthYear : ""
/// breed : ""
/// complains : {"clientPath":"","conditions":{"date":"","id":"","path":"","suspectedDiseases":{"desceseCategoryId":"","id":"","path":""},"symptoms":"","treatments":{"comment":"","date":45454,"drugs":{"cost":"","id":"","name":"","path":"","price":""},"followUpPerson":"","followuUpDate":"","id":"","nextCommingDate":45545,"path":""}},"differentialDiagnosis":{"comment":"","id":"","name":"","path":""},"id":"","initialComplain":"","nextFollowUpDate":"","path":""}
/// gender : ""
/// id : ""
/// name : ""
/// path : ""
/// pregnancyCycles : {"DeleviryMode":"","bleedingStartedDate":4544,"bleedingStoppedDate":4544,"crossingDates":4,"deliveryDate":"","logs":"","noOfChildren":"","scannigs":{"comment":"","date":"","id":"","path":""}}
/// vaccinations : {"givnDate":45454,"id":"","nextArvDate":454454,"nextDate":45454,"nextVaccination":"","path":"","vaccination":{"cost":6556.55,"expDate":4554545,"name":"","price":454.55,"purchassedDate":545454545,"supplier":"","vaccineId":""}}
/// weight : {"comment":"","date":4545,"weight":45.3}

class Pet {
  String? attention;
  int? birthDay;
  int? addedDateTime;
  String? breed;
  List<Complain?>? allComplains;
  List<Complain?>? activeComplains;
  List<Complain?>? completeComplains;
  List<Complain?>? dismissedComplains;
  String? gender;
  String? id;
  String? name;
  String? path;
  String? birthYear;
  bool? knowBirthDay;
  String? qrCode;
  String? clientId;
  String? clientName;
  String? doctorId;
  String? balance;
  String? status;
  List<PregnancyCycle?>? pregnancyCycles;
  List<Vaccination?>? allVaccinations;
  List<Vaccination?>? calledVaccinations;
  List<Vaccination?>? notCalledVaccinations;
  List<Vaccination?>? dismissedVaccinations;
  List<Weight?>? weight;
  List<ImageModel?>? images;


  Pet(
      {this.attention,
      this.birthDay,
      this.breed,
      this.activeComplains,
      this.completeComplains,
      this.dismissedComplains,
      this.gender,
      this.id,
      required this.clientId,
      this.name,
      this.path,
      this.qrCode,
      this.pregnancyCycles,
      this.allVaccinations,
      this.calledVaccinations,
      this.notCalledVaccinations,
      this.dismissedVaccinations,
      this.weight,
      this.clientName,
      this.doctorId,
      this.knowBirthDay = true,
      this.images,
        this.birthYear,
      this.allComplains,
        this.balance,
        this.status,
        this.addedDateTime
      });

  Pet.fromJson(dynamic json) {

    List<Complain> _allComplainList = [];
    List<Complain> _activeComplainList = [];
    List<Complain> _completedComplainList = [];
    List<Complain> _dismissedComplainList = [];

    if (json['complains'] != null) {
      Map<dynamic, dynamic> _map = json['complains'] as Map<dynamic, dynamic>;
      if (_map['activeComplains'] != null) {
        _map['activeComplains'].forEach(
          (key, element) {
            _activeComplainList.add(Complain.fromJson(element));
          },
        );
      }

      if (_map['completeComplains'] != null) {
        _map['completeComplains'].forEach(
          (key, element) {
            _completedComplainList.add(Complain.fromJson(element));
          },
        );
      }

      if (_map['dismissedComplains'] != null) {
        _map['dismissedComplains'].forEach(
          (key, element) {
            _dismissedComplainList.add(Complain.fromJson(element));
          },
        );
      }

      if (_map['allComplains'] != null) {
        _map['allComplains'].forEach(
          (key, element) {
            _allComplainList.add(Complain.fromJson(element));
          },
        );
      }
    }
allComplains = _allComplainList;
    completeComplains = _completedComplainList;
    dismissedComplains = _dismissedComplainList;
    activeComplains = _activeComplainList;

    List<PregnancyCycle> _pregnancyCycleList = [];
    if (json['pregnancyCycles'] != null) {
      Map<dynamic, dynamic> _map =
          json['pregnancyCycles'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _pregnancyCycleList.add(PregnancyCycle.fromJson(element));
        },
      );
    }

    List<ImageModel> _imageModelList = [];
    if (json['images'] != null) {
      Map<dynamic, dynamic> _map = json['images'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _imageModelList.add(ImageModel.fromJson(element));
        },
      );
    }

    List<Vaccination> _allVaccinationList = [];
    List<Vaccination> _calledVaccinationList = [];
    List<Vaccination> _notCalledVaccinationList = [];
    List<Vaccination> _dismissedVaccinationList = [];

    if (json['vaccinations'] != null) {
      Map<dynamic, dynamic> _map =
          json['vaccinations'] as Map<dynamic, dynamic>;
      if (_map['allVaccinations'] != null) {
        _map['allVaccinations'].forEach(
          (key, element) {
            _allVaccinationList.add(Vaccination.fromJson(element));
          },
        );
      }
      if (_map['calledVaccinations'] != null) {
        _map['calledVaccinations'].forEach(
          (key, element) {
            _calledVaccinationList.add(Vaccination.fromJson(element));
          },
        );
      }
      if (_map['notCalledVaccinations'] != null) {
        _map['notCalledVaccinations'].forEach(
          (key, element) {
            _notCalledVaccinationList.add(Vaccination.fromJson(element));
          },
        );
      }

      if (_map['dismissedVaccinations'] != null) {
        _map['dismissedVaccinations'].forEach(
          (key, element) {
            _allVaccinationList.add(Vaccination.fromJson(element));
          },
        );
      }
    }

    List<Weight> _weightList = [];
    if (json['weight'] != null) {
      Map<dynamic, dynamic> _map = json['weight'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _weightList.add(Weight.fromJson(element));
        },
      );
    }

    attention = json['attention'].toString();
    birthDay = json['birthDay'];
    breed = json['breed'];
    balance = json['balance'];
    gender = json['gender'];
    id = json['id'];
    clientId = json['clientId'];
    name = json['name'];
    path = json['path'];
    qrCode = json['qrCode'];
    status = json['status'];
    pregnancyCycles = _pregnancyCycleList;
    allVaccinations = _allVaccinationList;
    weight = _weightList;
    images = _imageModelList;

    knowBirthDay = json['knowBirthDay'];
    clientName = json['clientName'];
    doctorId = json['doctorId'];
    addedDateTime = json['addedDateTime'];
    birthYear = json['birthYear'];

  }

  Pet copyWith({
    String? attention,
    int? birthDay,
    String? birthMonth,
    String? birthYear,
    String? breed,
    List<Complain?>? allComplains,
    List<Complain?>? activeComplains,
    List<Complain?>? completeComplains,
    List<Complain?>? dismissedComplains,
    String? gender,
    String? id,
    String? clientId,
    String? qrCode,
    String? name,
    String? path,
    String? clientName,
    String? doctorId,
    String? balance,
    bool? knowBirthday,
    String? status,

    List<PregnancyCycle?>? pregnancyCycles,
    List<Vaccination?>? allVaccinations,
    List<Vaccination?>? calledVaccinations,
    List<Vaccination?>? notCalledVaccinations,
    List<Vaccination?>? dismissedVaccinations,
    List<Weight?>? weight,
    List<ImageModel?>? images,
    int? addedDateTime,
  }) =>
      Pet(
        attention: attention ?? this.attention,
        birthDay: birthDay ?? this.birthDay,
        breed: breed ?? this.breed,
        activeComplains: activeComplains ?? this.activeComplains,
        completeComplains: completeComplains ?? this.completeComplains,
        dismissedComplains: dismissedComplains ?? this.dismissedComplains,
        allComplains: allComplains ?? this.allComplains,
        gender: gender ?? this.gender,
        qrCode: qrCode ?? this.qrCode,
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        path: path ?? this.path,
        knowBirthDay: knowBirthDay ?? knowBirthDay,
        pregnancyCycles: pregnancyCycles ?? this.pregnancyCycles,
        weight: weight ?? this.weight,
        images: images ?? this.images,
        clientName: clientName ?? this.clientName,
        doctorId: doctorId ?? this.doctorId,
        balance: balance ?? this.balance,
        status: status ?? this.status,
        addedDateTime:  addedDateTime ?? this.addedDateTime,
        notCalledVaccinations: notCalledVaccinations ?? this.notCalledVaccinations,
        dismissedVaccinations: dismissedVaccinations ?? this.dismissedVaccinations,
        calledVaccinations: calledVaccinations ?? this.calledVaccinations,
        allVaccinations: allVaccinations ?? this.allVaccinations,
        birthYear: birthYear ?? this.birthYear,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attention'] = attention;
    map['birthDay'] = birthDay;
    map['breed'] = breed;
    map['gender'] = gender;
    map['id'] = id.toString();
    map['clientId'] = clientId.toString();
    map['name'] = name != null ? name!.toLowerCase() : null;
    map['path'] = path;
    map['knowBirthDay'] = knowBirthDay;
    map['qrCode'] = qrCode;
    map['balance'] = balance;
    map['clientName'] = clientName;
    map['doctorId'] = doctorId;
    map['status'] = status;
    map['addedDateTime'] = addedDateTime;
    map['birthYear'] = birthYear;

    Map<String, dynamic> vaccinationDetailsMap = {};
    Map<String, dynamic> complainDetailsMap = {};
    Map<String, dynamic> allVaccinationMap = {};

    if (allVaccinations != null && allVaccinations!.isNotEmpty) {
      for (var element in allVaccinations!) {
        allVaccinationMap[element!.id!] = element.toJson();
      }
      vaccinationDetailsMap['allVaccinations'] = allVaccinationMap;
    }

    Map<String, dynamic> calledVaccinationMap = {};
    if (calledVaccinations != null && calledVaccinations!.isNotEmpty) {
      for (var element in calledVaccinations!) {
        calledVaccinationMap[element!.id!] = element.toJson();
      }
      vaccinationDetailsMap['calledVaccinations'] = calledVaccinationMap;
    }

    Map<String, dynamic> notCalledVaccinationsMap = {};
    if (notCalledVaccinations != null && notCalledVaccinations!.isNotEmpty) {
      for (var element in notCalledVaccinations!) {
        notCalledVaccinationsMap[element!.id!] = element.toJson();
      }
      vaccinationDetailsMap['notCalledVaccinations'] = notCalledVaccinationsMap;
    }

    Map<String, dynamic> dismissedVaccinationsMap = {};
    if (dismissedVaccinations != null  && dismissedVaccinations!.isNotEmpty) {
      for (var element in dismissedVaccinations!) {
        dismissedVaccinationsMap[element!.id!] = element.toJson();
      }
      vaccinationDetailsMap['dismissedVaccinations'] = dismissedVaccinationsMap;
    }

    Map<String, dynamic> allComplainsMap = {};
    if (allComplains != null && allComplains!.isNotEmpty) {
      for (var element in allComplains!) {
        allComplainsMap[element!.id!] = element.toJson();
      }
      complainDetailsMap['allComplains'] = allComplainsMap;
    }

    Map<String, dynamic> completeComplainsMap = {};
    if (completeComplains != null && completeComplains!.isNotEmpty) {
      for (var element in completeComplains!) {
        completeComplainsMap[element!.id!] = element.toJson();
      }
      complainDetailsMap['completeComplains'] = completeComplainsMap;
    }

    Map<String, dynamic> dismissedComplainsMap = {};
    if (dismissedComplains != null && dismissedComplains!.isNotEmpty) {
      for (var element in dismissedComplains!) {
        dismissedComplainsMap[element!.id!] = element.toJson();
      }
      complainDetailsMap['dismissedComplains'] = dismissedComplainsMap;
    }

    Map<String, dynamic> activeComplainsMap = {};
    if (activeComplains != null && activeComplains!.isNotEmpty) {
      for (var element in activeComplains!) {
        activeComplainsMap[element!.id!] = element.toJson();
      }
      complainDetailsMap['activeComplains'] = activeComplainsMap;
    }

map['complains'] = complainDetailsMap;
    map['vaccinations'] = vaccinationDetailsMap;




    return map;
  }

  Widget getComplainSummery() {
    List<Widget> widgetLst = [];
    for (var element in allComplains!) {
      widgetLst.add(
        Column(
          children: [
            Text(element!.getTitle()),
          ],
        ),
      );
    }

    Duration getAge(){
      return DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(birthDay!));
    }
    return Column(
      children: widgetLst,
    );
  }

  bool isProperlyVaccinated() {
    List<Vaccination?>? vaccinationList =  allVaccinations;
    if(vaccinationList!= null && vaccinationList.isNotEmpty){
      if(vaccinationList.length >1){
        vaccinationList.sort(
      (a, b) => (b!.nextDate ?? DateTime.now().millisecondsSinceEpoch) - (a!.nextDate ?? DateTime.now().millisecondsSinceEpoch),
    );}
    return DateTime.fromMicrosecondsSinceEpoch(vaccinationList.last!.nextDate ?? DateTime.now().microsecondsSinceEpoch)
            .difference(DateTime.now())
            .inDays <
        0;} else{
      return false;
    }
  }

  String getPetName(){
    return ((name!=null && name!= '')? name! : 'No Name').toTitleCase!;
  }

  String getBreed(){
    return ((breed!=null && breed != '')? breed! : 'No Breed').toTitleCase!;
  }


}
