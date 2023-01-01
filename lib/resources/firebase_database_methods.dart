import 'package:call_log/call_log.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';

import '../constants.dart';
import '../models/Contact.dart';
import '../models/Pet.dart';
import '../models/User_model.dart';
import '../models/Vaccination.dart';
import '../models/client_model.dart';
import '../models/complain/Complain.dart';
import '../models/log.dart';
import '../models/oldDb/OldCallLog.dart';
import '../models/oldDb/OldClient.dart';
import '../models/oldDb/OldComplain.dart';
import '../models/oldDb/OldContactNumber.dart';
import '../models/oldDb/OldPet.dart';
import '../models/oldDb/OldTreatDay.dart';
import '../models/oldDb/OldTreatmentCategory.dart';
import '../models/oldDb/OldVaccination.dart';
import '../models/sale/Invoice.dart';
import '../utils/utils.dart';
import 'database_object_paths/log_paths.dart';
import 'database_object_paths/vaccination_paths.dart';

class FirebaseDatabaseMethods {
  final DatabaseReference ref;

  FirebaseDatabaseMethods() : ref = FirebaseDatabase.instance.ref();

  // FirebaseDatabaseMethods._privateConstructor() : ref = FirebaseDatabase.instance.ref();

  // static final FirebaseDatabaseMethods _instance = FirebaseDatabaseMethods._privateConstructor();
  //
  // factory FirebaseDatabaseMethods() {
  //   return _instance;
  // }

  // FirebaseDatabaseMethods() : ref = FirebaseDatabase.instance.ref();

  Future<void> addMapToDb({required path, required Map map}) async {
    await ref.child(path).set(map);
  }

  DatabaseReference reference({required String path}) {
    return ref.child(path);
  }

  Future<void> updateBatch(Map<String, dynamic> map) async {
    await ref.update(map);
  }

  Stream<UserModel?> getDoctorDetailsStream(String doctorId) {
    UserModel? user;
    Stream<DatabaseEvent> dbStream = ref.child('users/$doctorId').onValue;
    print(dbStream);
    return (dbStream.map((event) => UserModel.fromJson(event.snapshot)));
  }

  Future<void> updateBatchUsingPath(
      {required String path, required Map<String, dynamic> map}) async {
    await FirebaseDatabase.instance.ref(path).update(map);
  }

  Future<void> blankJson(String path) {
    return ref.child(path).set({});
  }

  Future<List<Contact>> getSearchResults2(List<String> queries) async {
    List<Future<DataSnapshot>> snapshotFutures = [];

    for (String query in queries) {
      snapshotFutures.add(FirebaseDatabase.instance.ref("$doctorPath")
          .child('contactNumbersList')
          .orderByChild('clientName')
          .startAt(query)
          .endAt(query + '\uf8ff')
          .get());
    }

    List<DataSnapshot> snapshots = await Future.wait(snapshotFutures);
    List<Contact> contacts = [];
    snapshots.forEach((snapshot) {
      snapshot.children.forEach((element) {
        contacts.add(Contact.fromJson(element.value));
      });

    });
    // Transform the list of DataSnapshots into a list of Contact objects

    return contacts.toSet().toList();
  }



  Future<List<Contact>> getSearchResults(String searchQuery) async {
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .ref("$doctorPath")
        .child('contactNumbersList')
        .orderByChild('clientName')
        .startAt(searchQuery)
        .endAt(searchQuery + '\uf8ff')
        .get();

    List<Contact> contacts = [];
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    values.forEach((key, value) {
      Contact contact = Contact.fromJson(value);
      contact.id = key;
      contacts.add(contact);
    });
    return contacts;
  }



  Future<void> updateComplainField(
      {required String complainPath,
      required String complainId,
      required String field,
      required dynamic value}) async {
    await ref.update({
      '$complainPath/$field': value,
      '$doctorPath/complains/$complainId/$field': value
    });
  }

  Future<void> createACallLog(
      {required String clientId, required LogType logtype}) async {
    var now = DateTime.now();
    Log log = Log();
    Iterable<CallLogEntry> entries = await CallLog.query();
    Map<String, Log> callLogMap = {};

    entries.forEach((element) {
      callLogMap[element.timestamp.toString()] = Log(
          callLogEntry: element,
          clientId: clientId,
          path: '$doctorPath/callLogs/${element.timestamp}');
    });
    bool containValue = false;
    DataSnapshot snap = await FirebaseDatabaseMethods()
        .reference(path: '$doctorPath/callLogs')
        .get();
    if (snap.value != null) {
      //getting Id list from database callLogs
      List<String> callLogsIdsFromCloud = [];
      snap.children.forEach((element) async {
        callLogsIdsFromCloud
            .add((element.value as dynamic)['timestamp'].toString());
      });

      var callLogsIdsFromCloudSet = callLogsIdsFromCloud.toSet();
      var callLogIdsFromDeviceSet =
          entries.map((e) => e.timestamp.toString()).toSet();
      var onlyPhoneSet =
          callLogIdsFromDeviceSet.difference(callLogsIdsFromCloudSet);
      List<Log?> toUploadList = onlyPhoneSet.map((e) => callLogMap[e]).toList();

      if (toUploadList.isNotEmpty) {
        toUploadList.forEach((element) async {
          await FirebaseDatabaseMethods().updateBatch(updateLogJson(
              log: element!,
              clientId: clientId,
              logType: logtype,
              json: [log.toJson()]));
        });
      }
    } else {
      entries.forEach((element) async {
        Log callLogEntryWithComment = Log(
            callLogEntry: element,
            path: '$doctorPath/callLogs/${element.timestamp}');
        await FirebaseDatabaseMethods().updateBatch(updateLogJson(
            log: callLogEntryWithComment,
            clientId: clientId,
            logType: logtype,
            json: [log.toJson()]));
      });
    }
  }

  Future<Invoice> getSaleFromID(String id) async {
    DataSnapshot snapshot = await reference(path: 'sales/$id').get();

    Map<dynamic, dynamic> map = {};

    snapshot.children.forEach((element) {
      map[element.key] = element.value;
    });
    Invoice sale = Invoice.fromJson(map);

    return sale;
  }

  Future<Map<dynamic, dynamic>> getMapFromPath({required String path}) async {
    DataSnapshot snapshot = await reference(path: path).get();

    Map<dynamic, dynamic> map = {};

    snapshot.children.forEach((element) {
      map[element.key] = element.value;
    });

    return map;
  }

  Future<Map<dynamic, dynamic>> getMapFromOldDB(
      {required String path, required String keyName}) async {
    DataSnapshot snapshot = await reference(path: path).get();

    Map<dynamic, dynamic> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)![keyName]] = element.value;
    });
    return map;
  }

  Future<Map<dynamic, OldClient>> getClientsFromOldDB() async {
    DataSnapshot snapshot = await reference(path: 'oldDB/clients').get();

    Map<dynamic, OldClient> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['key']] =
          OldClient.fromJson(element.value);
      print(element.value);
    });
    return map;
  }

  Future<Map<dynamic, OldContactNumber>> getContactsFromOldDB() async {
    DataSnapshot snapshot = await reference(path: 'oldDB/contactNumbers').get();

    Map<dynamic, OldContactNumber> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['key']] =
          OldContactNumber.fromJson(element.value);
    });
    return map;
  }

  Future<Map<dynamic, Pet>> getPetsList() async {
    print(
        '============================================================================= Getting Pet List');
    DataSnapshot snapshot = await reference(path: 'pets').get();
    print(snapshot.children.length);
    Map<dynamic, Pet> map = {};
    int i = 0;
    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['key']] = Pet.fromJson(element.value);
      print(i++);
      print(element.value);
    });
    return map;
  }

  Future<Map<dynamic, Contact>> getContactsList() async {
    DataSnapshot snapshot = await reference(path: 'contacts').get();

    Map<dynamic, Contact> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['key']] = Contact.fromJson(element.value);
      print(element.value);
    });
    return map;
  }

  Future<Map<dynamic, OldPet>> getPetsFromOldDB() async {
    DataSnapshot snapshot = await reference(path: 'oldDB/pets').get();

    Map<dynamic, OldPet> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['key']] = OldPet.fromJson(element.value);
    });
    return map;
  }

  Future<Map<dynamic, OldTreatDay>> getTreatDaysFromOldDB() async {
    DataSnapshot snapshot = await reference(path: 'oldDB/treatDays').get();

    Map<dynamic, OldTreatDay> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['key']] =
          OldTreatDay.fromJson(element.value);
      print(element.value);
    });
    return map;
  }

  Future<Map<dynamic, OldCallLog>> getCallLogsFromOldDB() async {
    DataSnapshot snapshot = await reference(path: 'oldDB/callLogs').get();

    Map<dynamic, OldCallLog> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['key']] =
          OldCallLog.fromJson(element.value);
    });
    return map;
  }

  Future<Map<dynamic, OldComplain>> getComplainsFromOldDB() async {
    DataSnapshot snapshot = await reference(path: 'oldDB/complains').get();

    Map<dynamic, OldComplain> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['key']] =
          OldComplain.fromJson(element.value);
    });
    return map;
  }

  Future<Map<dynamic, OldVaccination>> getVaccinationsFromOldDB() async {
    DataSnapshot snapshot = await reference(path: 'oldDB/vaccinations').get();

    Map<dynamic, OldVaccination> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['key']] =
          OldVaccination.fromJson(element.value);
    });
    return map;
  }

  Future<Map<dynamic, Vaccination>> getVaccinationsList() async {
    DataSnapshot snapshot = await reference(path: 'vaccinations/all').get();

    Map<dynamic, Vaccination> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['id']] =
          Vaccination.fromJson(element.value);
    });
    return map;
  }

  Future<Map<dynamic, Complain>> getAllComplainsList() async {
    DataSnapshot snapshot = await reference(path: 'complains/all').get();

    Map<dynamic, Complain> map = {};

    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['id']] = Complain.fromJson(element.value);
    });
    return map;
  }

  Future<Map<dynamic, OldTreatmentCategory>>
      getTreatmentCategoriesFromOldDB() async {
    DataSnapshot snapshot =
        await reference(path: 'oldDB/treatmentCategory').get();

    Map<dynamic, OldTreatmentCategory> map = {};
    print('------------- Categories');
    snapshot.children.forEach((element) {
      map[(element.value as dynamic)!['id']] =
          OldTreatmentCategory.fromJson(element.value);
      print(element.value);
    });
    return map;
  }

  Future<Pet> getPetFromID({required String id}) async {
    DataSnapshot snapshot = await reference(path: '$doctorPath/pets/$id').get();

    Map<dynamic, dynamic> map = {};

    snapshot.children.forEach((element) {
      map[element.key] = element.value;
    });
    Pet pet = Pet.fromJson(map);

    return pet;
  }

  Future<Map<dynamic, dynamic>> getFirstExaminationCategories() async {
    DataSnapshot snapshot =
        await reference(path: examinationCategoriesPath).get();

    Map<dynamic, dynamic> map = {};

    snapshot.children.forEach((element) {
      map[element.key] = element.value;
    });

    return map;
  }

  Future<ClientModel> getClientFromID(
      {required String id,
      ClientStatus clientStatus = ClientStatus.real}) async {
    DataSnapshot snapshot =
        await reference(path: 'clients/${clientStatus.name}/$id').get();

    Map<dynamic, dynamic> map = {};

    snapshot.children.forEach((element) {
      map[element.key] = element.value;
    });
    ClientModel client = ClientModel.fromJson(map);

    return client;
  }

  Future<Vaccination> getVaccinationFromID(
      {required String id,
      required VaccinationStatus vaccinationStatus}) async {
    DataSnapshot snapshot =
        await reference(path: 'vaccinations/$vaccinationStatus/$id').get();

    Map<dynamic, dynamic> map = {};

    snapshot.children.forEach((element) {
      map[element.key] = element.value;
    });
    Vaccination vaccination = Vaccination.fromJson(map);

    return vaccination;
  }

  Future<void> createLastCallLog({
    required String? petId,
    String? calledFor,
    String? comment,
    String? clientId,
    String? vaccinationId,
    String? complainId,
    String? vaccinationPath,
    String? complainPath,
    String? toDoctorId,
    required LogType logType,
  }) async {
    //Allowing some time to create the phone call Log

    Iterable<CallLogEntry> entries = await CallLog.query(
        dateFrom: DateTime.now()
            .subtract(const Duration(days: 1))
            .millisecondsSinceEpoch);

    Log log = Log(
      id: dateTimeDescender(dateTime: DateTime.now()).toString(),
      callLogEntry: entries.first,
      clientId: clientId,
      calledFor: calledFor,
      comment: comment,
      addedBy: FirebaseAuth.instance.currentUser!.email,
      path: '$doctorPath/logs/${entries.first.timestamp}',
      complainId: complainId,
      vaccinationId: vaccinationId,
      isACall: true,
      complainPath: complainPath,
      vaccinationPath: vaccinationPath,
      addedById: FirebaseAuth.instance.currentUser!.uid,
      dateTime: DateTime.now().microsecondsSinceEpoch,
      toDoctorId: toDoctorId,
      addedByName: FirebaseAuth.instance.currentUser!.displayName,
    );

    await updateBatch(updateLogJson(
        log: log,
        petId: petId,
        clientId: clientId!,
        complainId: complainId,
        vaccinationId: vaccinationId,
        logType: vaccinationId != null
            ? LogType.vaccination
            : complainId != null
                ? LogType.complain
                : LogType.other,
        json: [log.toJson()]));
  }
}
