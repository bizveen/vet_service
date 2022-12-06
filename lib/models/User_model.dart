
import 'Pet.dart';
import 'area.dart';
import 'client_model.dart';
import 'comment.dart';
import 'Disease.dart';

import 'Hospital.dart';
import 'Supplier.dart';
import 'Vaccine.dart';
import 'complain/Drug.dart';

/// areas : {"id":"","name":"","path":"","region":""}
/// clients : {"address":"","id":"","log":{"comment":"","id":"","path":"","type":""},"name":"","path":"","pets":{"attention":"","birthDay":"","birthMonth":"","birthYear":"","breed":"","complains":{"clientPath":"","conditions":{"date":"","id":"","path":"","suspectedDiseases":{"desceseCategoryId":"","id":"","path":""},"symptoms":"","treatments":{"comment":"","date":45454,"drugs":{"cost":"","id":"","name":"","path":"","price":""},"followUpPerson":"","followuUpDate":"","id":"","nextCommingDate":45545,"path":""}},"differentialDiagnosis":{"comment":"","id":"","name":"","path":""},"id":"","initialComplain":"","nextFollowUpDate":"","path":""},"gender":"","id":"","name":"","path":"","pregnancyCycles":{"DeleviryMode":"","bleedingStartedDate":4544,"bleedingStoppedDate":4544,"crossingDates":4,"deliveryDate":"","logs":"","noOfChildren":"","scannigs":{"comment":"","date":"","id":"","path":""}},"vaccinations":{"givnDate":45454,"id":"","nextArvDate":454454,"nextDate":45454,"nextVaccination":"","path":"","vaccination":{"cost":6556.55,"expDate":4554545,"name":"","price":454.55,"purchassedDate":545454545,"supplier":"","vaccineId":""}},"weight":{"comment":"","date":4545,"weight":45.3}},"purchasing":{"cost":"","id":"","isComplete":"","paidAmount":"","path":"","price":"","serviceId":"","treatmentId":"","type":"","vaccineId":""}}
/// comments : {"comment":"","date":"","id":"","path":""}
/// diseases : {"group":"","id":"","name":"","path":""}
/// doctorId : ""
/// drugs : {"cost":"","extra":"","id":"","name":"","path":""}
/// hospitals : {"address":"","contacts":"","id":"","path":"","staff":{"comments":"","id":"","path":"","role":"","userId":""}}
/// id : ""
/// location : ""
/// name : ""
/// path : ""
/// searchIndex : ""
/// startedDay : ""
/// suppliers : {"address":"","contacts":"","id":"","name":"","path":""}
/// userRole : ""
/// vaccines : {"cost":"","descriotion":"","id":"","name":"","path":"","retailPrice":"","supplier":""}

class UserModel {
  List<Area?>? areas;
  List<ClientModel?>? clients;
  List<Pet?>? pets;
  List<Comment?>? comments;
  List<Disease?>? diseases;
  String? doctorId;
  List<Drug?>? drugs;
  List<Hospital?>? hospitals;
  String? id;
  String? location;
  String? name;
  String? path;
  String? searchIndex;
  String? startedDay;
  List<Supplier?>? suppliers;
  String? userRole;
  List<Vaccines?>? vaccines;

  UserModel({
    this.areas,
    this.clients,
    this.comments,
    this.diseases,
    this.doctorId,
    this.drugs,
    this.hospitals,
    this.id,
    this.location,
    this.name,
    this.path,
    this.searchIndex,
    this.startedDay,
    this.suppliers,
    this.userRole,
    this.vaccines,
    this.pets
  });

  UserModel.fromJson(dynamic json) {
    List<ClientModel> _clientList = [];
    if (json['clients'] != null) {
      Map<dynamic, dynamic> _map = json['clients'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _clientList.add(ClientModel.fromJson(element));
        },
      ); //print(petList.length);
    }

    List<Pet> _petsList = [];
    if (json['clients'] != null) {
      Map<dynamic, dynamic> _map = json['pets'] as Map<dynamic, dynamic>;

      _map.forEach(
            (key, element) {
              _petsList.add(Pet.fromJson(element));
        },
      ); //print(petList.length);
    }



    List<Area> _areaList = [];
    if (json['areas'] != null) {
      Map<dynamic, dynamic> _map = json['areas'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _areaList.add(Area.fromJson(element));
        },
      ); //print(petList.length);
    }

    List<Comment> _commentList = [];
    if (json['comments'] != null) {
      Map<dynamic, dynamic> _map = json['comments'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _commentList.add(Comment.fromJson(element));
        },
      ); //print(petList.length);
    }

    List<Disease> _diseaseList = [];
    if (json['diseases'] != null) {
      Map<dynamic, dynamic> _map = json['diseases'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _diseaseList.add(Disease.fromJson(element));
        },
      ); //print(petList.length);
    }

    List<Drug> _drugList = [];
    if (json['drugs'] != null) {
      Map<dynamic, dynamic> _map = json['drugs'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _drugList.add(Drug.fromJson(element));
        },
      ); //print(petList.length);
    }

    List<Hospital> _hospitalList = [];
    if (json['hospitals'] != null) {
      Map<dynamic, dynamic> _map = json['hospitals'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _hospitalList.add(Hospital.fromJson(element));
        },
      );
    }
    List<Supplier> _supplierList = [];
    if (json['suppliers'] != null) {
      Map<dynamic, dynamic> _map = json['suppliers'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _supplierList.add(Supplier.fromJson(element));
        },
      );
    }
    List<Vaccines> _vaccineList = [];
    if (json['vaccines'] != null) {
      Map<dynamic, dynamic> _map = json['vaccines'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _vaccineList.add(Vaccines.fromJson(element));
        },
      );
    }
    areas = _areaList;
    clients = _clientList;
    comments = _commentList;
    diseases = _diseaseList;
    doctorId = json['doctorId'];
    drugs = _drugList;
    hospitals = _hospitalList;
    id = json['id'];
    location = json['location'];
    name = json['name'];
    path = json['path'];
    searchIndex = json['searchIndex'];
    startedDay = json['startedDay'];
    suppliers = _supplierList;
    userRole = json['userRole'];
    vaccines = _vaccineList;
    pets = _petsList;
  }

  UserModel copyWith({
    List<Area?>? areas,
    List<ClientModel?>? clients,
    List<Comment?>? comments,
    List<Disease?>? diseases,
    String? doctorId,
    List<Drug?>? drugs,
    List<Hospital?>? hospitals,
    String? id,
    String? location,
    String? name,
    String? path,
    String? searchIndex,
    String? startedDay,
    List<Supplier?>? suppliers,
    String? userRole,
    List<Vaccines?>? vaccines,
    List<Pet?>? pets,
  }) =>
      UserModel(
        areas: areas ?? this.areas,
        clients: clients ?? this.clients,
        comments: comments ?? this.comments,
        diseases: diseases ?? this.diseases,
        doctorId: doctorId ?? this.doctorId,
        drugs: drugs ?? this.drugs,
        hospitals: hospitals ?? this.hospitals,
        id: id ?? this.id,
        location: location ?? this.location,
        name: name ?? this.name,
        path: path ?? this.path,
        searchIndex: searchIndex ?? this.searchIndex,
        startedDay: startedDay ?? this.startedDay,
        suppliers: suppliers ?? this.suppliers,
        userRole: userRole ?? this.userRole,
        vaccines: vaccines ?? this.vaccines,
        pets: pets?? this.pets
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['location'] = location;
    map['name'] = name;
    map['path'] = path;
    map['searchIndex'] = searchIndex;
    map['startedDay'] = startedDay;

    map['userRole'] = userRole;

    return map;
  }
}
