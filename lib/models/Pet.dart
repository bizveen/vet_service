import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:vet_service/models/TimeLineElement.dart';

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
  List<Complain?>? complains;

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
  List<Vaccination?>? vaccinations;

  List<Weight?>? weight;
  List<TimeLineElement?>? timeLine;


  Pet({this.attention,
    this.birthDay,
    this.breed,
    this.complains,
    this.gender,
    this.id,
    required this.clientId,
    this.name,
    this.path,
    this.qrCode,
    this.pregnancyCycles,
    this.vaccinations,
    this.weight,
    this.clientName,
    this.doctorId,
    this.knowBirthDay = true,
    this.timeLine,
    this.birthYear,

    this.balance,
    this.status,
    this.addedDateTime
  });

  Pet.fromJson(dynamic json) {
    List<Complain> _complains = [];


    if (json['complains'] != null) {
      Map<dynamic, dynamic> _map = json['complains'] as Map<dynamic, dynamic>;

      _map.forEach(
            (key, element) {
          _complains.add(Complain.fromJson(element));
        },
      );
    }

    complains = _complains;




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

    List<TimeLineElement> _timeLineLementsList = [];
    if (json['timeLine'] != null) {
      Map<dynamic, dynamic> _map = json['timeLine'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _timeLineLementsList.add(TimeLineElement.fromJson(element));
        },
      );
    }

    List<Vaccination> _vaccinations = [];

    if (json['vaccinations'] != null) {
      Map<dynamic, dynamic> _map =
          json['vaccinations'] as Map<dynamic, dynamic>;
      _map.forEach(
          (key, element) {
            _vaccinations.add(Vaccination.fromJson(element));
      }
    );
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

    weight = _weightList;
    timeLine = _timeLineLementsList;

    knowBirthDay = json['knowBirthDay'];
    clientName = json['clientName'];
    doctorId = json['doctorId'];
    addedDateTime = json['addedDateTime'];
    birthYear = json['birthYear'];
vaccinations = _vaccinations;
  }

  Pet copyWith({
    String? attention,
    int? birthDay,
    String? birthMonth,
    String? birthYear,
    String? breed,
    List<Complain?>? complains,

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
    List<Vaccination?>? vaccinations,
    List<Weight?>? weight,
    List<TimeLineElement?>? timeLineElementsList,
    int? addedDateTime,
  }) =>
      Pet(
        attention: attention ?? this.attention,
        birthDay: birthDay ?? this.birthDay,
        breed: breed ?? this.breed,

        complains: complains ?? this.complains,
        gender: gender ?? this.gender,
        qrCode: qrCode ?? this.qrCode,
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        path: path ?? this.path,
        knowBirthDay: knowBirthDay ?? knowBirthDay,
        pregnancyCycles: pregnancyCycles ?? this.pregnancyCycles,
        weight: weight ?? this.weight,
        timeLine: timeLineElementsList ?? this.timeLine,
        clientName: clientName ?? this.clientName,
        doctorId: doctorId ?? this.doctorId,
        balance: balance ?? this.balance,
        status: status ?? this.status,
        addedDateTime:  addedDateTime ?? this.addedDateTime,
        vaccinations: vaccinations ?? this.vaccinations,
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

    if (vaccinations != null && vaccinations!.isNotEmpty) {
      for (var element in vaccinations!) {
        allVaccinationMap[element!.id!] = element.toJson();
      }
      vaccinationDetailsMap['vaccinations'] = allVaccinationMap;
    }


    Map<String, dynamic> allComplainsMap = {};
    if (complains != null && complains!.isNotEmpty) {
      for (var element in complains!) {
        allComplainsMap[element!.id!] = element.toJson();
      }
      complainDetailsMap['complains'] = allComplainsMap;
    }



map['complains'] = complainDetailsMap;
    map['vaccinations'] = vaccinationDetailsMap;




    return map;
  }

  Widget getComplainSummery() {
    List<Widget> widgetLst = [];
    for (var element in complains!) {
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
    List<Vaccination?>? vaccinationList =  vaccinations;
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
