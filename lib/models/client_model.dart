import 'Contact.dart';
import 'Pet.dart';
import 'Purchasing.dart';
import 'log.dart';
import 'sale/Sale.dart';

/// address : ""
/// id : ""
/// log : {"comment":"","id":"","path":"","type":""}
/// name : ""
/// path : ""
/// pets : {"attention":"","birthDay":"","birthMonth":"","birthYear":"","breed":"","complains":{"clientPath":"","conditions":{"date":"","id":"","path":"","suspectedDiseases":{"desceseCategoryId":"","id":"","path":""},"symptoms":"","treatments":{"comment":"","date":45454,"drugs":{"cost":"","id":"","name":"","path":"","price":""},"followUpPerson":"","followuUpDate":"","id":"","nextCommingDate":45545,"path":""}},"differentialDiagnosis":{"comment":"","id":"","name":"","path":""},"id":"","initialComplain":"","nextFollowUpDate":"","path":""},"gender":"","id":"","name":"","path":"","pregnancyCycles":{"DeleviryMode":"","bleedingStartedDate":4544,"bleedingStoppedDate":4544,"crossingDates":4,"deliveryDate":"","logs":"","noOfChildren":"","scannigs":{"comment":"","date":"","id":"","path":""}},"vaccinations":{"givnDate":45454,"id":"","nextArvDate":454454,"nextDate":45454,"nextVaccination":"","path":"","vaccination":{"cost":6556.55,"expDate":4554545,"name":"","price":454.55,"purchassedDate":545454545,"supplier":"","vaccineId":""}},"weight":{"comment":"","date":4545,"weight":45.3}}
/// purchasing : {"cost":"","id":"","isComplete":"","paidAmount":"","path":"","price":"","serviceId":"","treatmentId":"","type":"","vaccineId":""}
enum ClientStatus { real, fake }

class ClientModel {
  List<Contact?>? contacts;
  String? address;
  String? id;
  List<Log?>? logs;
  String? name;

  // List<String?>? paths;
  List<Pet?>? pets;
  List<Purchasing?>? purchasing;
  List<Sale?>? salesList;
  String? area;
  String? currentActiveCaseId;
  String? searchIndex;
  bool? isActive;
  String? doctorId;
  int? clientStatus;
  String? balance;

  ClientModel(
      {this.contacts,
      this.currentActiveCaseId,
      this.address,
      this.id,
      this.area,
      this.logs,
      this.name,
      // this.paths,
      this.pets,
      this.purchasing,
      this.searchIndex,
      this.isActive,
      this.salesList,
      this.doctorId,
      required this.clientStatus,
      this.balance});

  ClientModel.fromJson(dynamic json) {
    clientStatus = json['clientStatus'];
    List<Log> _logList = [];
    if (json['logs'] != null) {
      Map<dynamic, dynamic> _map = json['logs'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _logList.add(Log.fromJson(
            map: element,
          ));
        },
      );
    }
    logs = _logList;

    List<Sale> _salesList = [];

    if (json['sales'] != null) {
      Map<dynamic, dynamic> _map = json['sales'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _salesList.add(Sale.fromJson(element));
        },
      );
    }
    salesList = _salesList;

    List<String?>? _pathList = [];

    List<Contact> _contactList = [];
    if (json['contacts'] != null) {
      Map<dynamic, dynamic> _map = json['contacts'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _contactList.add(Contact.fromJson(element));
        },
      );
    }
    contacts = _contactList;

    List<Pet> _petList = [];
    if (json['pets'] != null) {
      Map<dynamic, dynamic> _map = json['pets'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _petList.add(Pet.fromJson(element));
        },
      );
    }
    pets = _petList;

    List<Purchasing> _purchasingList = [];
    if (json['purchasings'] != null) {
      Map<dynamic, dynamic> _map = json['purchasings'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _purchasingList.add(Purchasing.fromJson(element));
        },
      );
    }
    purchasing = _purchasingList;

    area = json['area'];
    address = json['address'];
    id = json['id'];
    name = json['name'];
    balance = json['balance'];

    // paths = json['path'];
    searchIndex = json['searchIndex'];
    isActive = json['isActive'];
    currentActiveCaseId = json['currentActiveCaseId'];
    doctorId = json['doctorId'];
  }

  ClientModel copyWith({
    String? address,
    String? id,
    String? area,
    List<Log?>? logs,
    List<Contact?>? contacts,
    String? name,
    List<String?>? paths,
    List<Pet?>? pets,
    List<Purchasing?>? purchasing,
    String? currentActiveCaseId,
    String? searchIndex,
    bool? isActive,
    String? doctorId,
    List<Sale?>? salesList,
    int? clientStatus,
    String? balance,
  }) =>
      ClientModel(
          address: address ?? this.address,
          id: id ?? this.id,
          area: area ?? this.area,
          logs: logs ?? this.logs,
          name: name ?? this.name,
          // paths: paths ?? this.paths,
          pets: pets ?? this.pets,
          salesList: salesList ?? this.salesList,
          isActive: isActive ?? this.isActive,
          contacts: contacts ?? this.contacts,
          purchasing: purchasing ?? this.purchasing,
          searchIndex: searchIndex ?? this.searchIndex,
          currentActiveCaseId: currentActiveCaseId ?? this.currentActiveCaseId,
          doctorId: doctorId ?? this.doctorId,
          clientStatus: clientStatus ?? this.clientStatus,
          balance: balance ?? this.balance);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    Map<String, Map<String, dynamic>> contactMap = {};
    if (contacts != null && contacts!.isNotEmpty) {
      for (var element in contacts!) {
       // contactMap[element!.contactNumber!] = element.toJson();
      }
    }
    map['address'] = address;
    map['id'] = id;

    map['name'] = name != null ? name!.toLowerCase() : null;
    // map['paths'] = pathMap;
    map['area'] = area;
    map['contacts'] = contactMap;
    map['currentActiveCaseId'] = currentActiveCaseId;
    map['searchIndex'] = searchIndex;
    map['isActive'] = isActive;
    map['doctorId'] = doctorId;
    map['clientStatus'] = clientStatus;
    map['balance'] = balance;

    if (pets != null) {
      Map<String, dynamic> petMap = {};
      pets!.forEach((element) {
        petMap[element!.id!] = element.toJson();
      });
      map['pets'] = petMap;
    }
    return map;
  }
}
