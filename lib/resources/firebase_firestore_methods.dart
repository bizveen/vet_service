import 'dart:convert';
import 'dart:developer';

import 'package:call_log/call_log.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:firebase_database/firebase_database.dart';

import '../constants.dart';
import '../controllers/global_live_variables_controller.dart';
import '../models/Pet.dart';
import '../models/client_model.dart';
import '../models/log.dart';
import 'firebase_database_methods.dart';

class FirebaseFirestoreMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> wordToElementList(String word) {
    List<String> elementList = [];
    for (int i = 0; i < word.length; i++) {
      elementList.add(word.substring(0, i + 1));
    }
    return elementList;
  }

  // List<String> wordPermutations(List<String> wordList) {
  //   List<String> permutations = [];
  //
  //   final permutationsSet = wordList,
  //       perms = Permutations(wordList.length, wordList);
  //
  //   for (final perms in perms()) {
  //     String temp = '';
  //     for (var element in perms) {
  //       temp = temp + ' ' + element.toString();
  //     }
  //     permutations.add(temp.trimLeft());
  //   }
  //   return permutations;
  //   // return wordsCombineList;
  // }

  // List<String> wordListToElementList(List<String> wordsList) {
  //   List<String> elementList = [];
  //   List<String> permutationList = wordPermutations(wordsList);
  //   permutationList.forEach((element) {
  //     if (element != '' || !elementList.contains(element) || element != ' ') {
  //       elementList = elementList + wordToElementList(element);
  //     }
  //   });
  //   //log(elementList.length.toString() , name: 'Length');
  //
  //   return elementList.toSet().toList();
  // }

  addDataToCallLogs(String key, Map<String, dynamic> map) async {
    await firestore
        .collection(
            'users/${Get.find<GlobalLiveVariablesController>().currentDoctor}/callLogs/')
        .doc(key)
        .set(map);
  }

  // addClientToSearch(
  //     {required String clientId, required List<String> searchWords}) async {
  //   try {
  //     await firestore
  //         .collection(
  //             'users/${Get.find<GlobalLiveVariablesController>().currentDoctor}/clients/')
  //         .doc(clientId)
  //         .set({
  //       'id': clientId,
  //       'clientSearch': wordListToElementList(searchWords),
  //       //'contactNumbers': wordListToElementList(contactNumbers),
  //     });
  //   } on FirebaseException catch (e) {
  //     log('${e.message}', name: 'Error');
  //   }
  // }

  addClientSearchDataFromDatabaseData(String clientId) async {
    List<String> words = [];
    DataSnapshot snapshot = await FirebaseDatabaseMethods()
        .reference(
            path:
                'users/${Get.find<GlobalLiveVariablesController>().currentDoctor}/clients/$clientId')
        .get();
    ClientModel client =
        ClientModel.fromJson(snapshot.value as Map<dynamic, dynamic>);
    words = words + client.name!.split(' ');
    for (var element in client.contacts!) {
      words.add(element!.contactNumber!);
    }
   // await addClientToSearch(clientId: clientId, searchWords: words);
  }

  addPetDataToSearch(
      {required String clientId, required List<String> searchWords}) {
    firestore
        .collection(
            'users/${Get.find<GlobalLiveVariablesController>().currentDoctor}/clients/')
        .doc(clientId)
        .update(
      {
        'petSearch': searchWords,
      },
    );
  }

 Future<ClientModel> getClientFromFirestore  (
      {required String clientId}) async {
   ClientModel client = ClientModel.fromJson(  (await firestore
        .collection(
        'clients')
        .doc(clientId).get()).data()
         );
   print('=========================++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
   print(client.toJson());
   return client;
  }


  addPetQrcodeToSearch(String clientId, String qrCode) {
    firestore
        .collection(
            'users/${Get.find<GlobalLiveVariablesController>().currentDoctor}/clients/')
        .doc(clientId)
        .update({
      'qrCodes': FieldValue.arrayUnion([qrCode]),
    });
  }

  addClientToFirestore(ClientModel client) async {
    // print("Inside Firestore Client Add");
    await firestore
        .collection(
        'clients')
        .doc(client.id!)
        .set(client.toJson());
  }



  updateClientValues({required String clientId, required String relativePath , required dynamic json}) async {
    try{
    await firestore
        .collection(
        'clients/').doc(clientId)
        .update({relativePath: json});
          }
          catch(e){
      print(e.toString());
    }
  }

  Future<void> updateCallLogs() async {
    //Allowing some time to create the phone call Log
    await Future.delayed(const Duration(seconds: 6));
    Iterable<CallLogEntry> entries = await CallLog.query(
        dateFrom: DateTime.now()
            .subtract(const Duration(days: 7))
            .millisecondsSinceEpoch);

    Map<String, Log> callLogMap = {};

    entries.forEach((element) {
      callLogMap[element.timestamp.toString()] = Log(
          callLogEntry: element,
          path: '$doctorPath/callLogs/${element.timestamp}');
    });
    bool containValue = false;
    QuerySnapshot snap = await firestore
        .collection('$doctorPath/callLogs')
        .where('timestamp',
            isGreaterThan: DateTime.now()
                .subtract(const Duration(days: 7))
                .millisecondsSinceEpoch)
        .get();

    if (snap.docs != null) {
      //getting Id list from database callLogs
      List<String> callLogsIdsFromCloud = [];
      snap.docs.forEach((element) async {
        callLogsIdsFromCloud
            .add((element.data() as dynamic)['timestamp'].toString());
      });

      var callLogsIdsFromCloudSet = callLogsIdsFromCloud.toSet();
      var callLogIdsFromDeviceSet =
          entries.map((e) => e.timestamp.toString()).toSet();
      var onlyPhoneSet =
          callLogIdsFromDeviceSet.difference(callLogsIdsFromCloudSet);
      List<Log?> toUploadList = onlyPhoneSet.map((e) => callLogMap[e]).toList();

      if (toUploadList.isNotEmpty) {
        toUploadList.forEach((element) async {
          await addDataToCallLogs(
              '${element!.callLogEntry?.timestamp.toString()}',
              element.toJson());
        });
      }
    } else {
      entries.forEach((element) async {
        Log callLogEntryWithComment = Log(
            callLogEntry: element,
            path: '$doctorPath/callLogs/${element.timestamp}');
        await addDataToCallLogs(
            '${element.timestamp}', callLogEntryWithComment.toJson());
      });
    }
  }

  Future<void> createLastCallLog(
      {String? calledFor, String? comment, required String? clientId}) async {
    //Allowing some time to create the phone call Log

    Iterable<CallLogEntry> entries = await CallLog.query(
        dateFrom: DateTime.now()
            .subtract(const Duration(days: 1))
            .millisecondsSinceEpoch);

    Log callLogEntryWithComment = Log(
        id: entries.first.timestamp.toString(),
        callLogEntry: entries.first,
        clientId: clientId,
        calledFor: calledFor,
        comment: comment,
        addedBy: FirebaseAuth.instance.currentUser!.email,
        path: '$doctorPath/callLogs/${entries.first.timestamp}');

    await addDataToCallLogs(
        callLogEntryWithComment.id!, callLogEntryWithComment.toJson());
  }
}
