import 'package:call_log/call_log.dart';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:string_extensions/string_extensions.dart';

import 'client_model.dart';

class Log {
  CallLogEntry? callLogEntry;
  String? complainPath;
  String? complainId;
  String? vaccinationPath;
  String? vaccinationId;
  String? treatmentId;
  String? treatmentPath;
  String? path;
  String? comment;
  String? addedBy;
  String? calledFor;
  String? id;
  String? clientId;
  String? salesId;
  ClientModel? client;
  bool isACall;
  int? dateTime;
  String? addedByName;
  String? addedById;
  String? toDoctorId;

  Log({
    this.callLogEntry,
    this.comment,
    this.addedBy,
    this.path ,
    this.calledFor ,
    this.id ,
    this.clientId ,
    this.complainPath,
    this.vaccinationPath,
    this.salesId,
    this.complainId,
    this.vaccinationId,
    this.client,
    this.isACall = true,
    this.treatmentId,
    this.treatmentPath,
    this.dateTime,
    this.addedById,
    this.addedByName,
    this.toDoctorId
  });

  toJson() {
    Map<String, dynamic> map = {};

    map['timestamp'] = callLogEntry?.timestamp;
    map['cachedMatchedNumber'] = callLogEntry?.cachedMatchedNumber;
    map['cachedNumberLabel'] = callLogEntry?.cachedNumberLabel;
    map['cachedNumberType'] = callLogEntry?.cachedNumberType;
    map['callType'] = callLogEntry?.callType!.index;
    map['duration'] = callLogEntry?.duration;
    map['formattedNumber'] = callLogEntry?.formattedNumber;
    map['name'] = callLogEntry?.name;
    map['number'] = callLogEntry?.number?.last(n: 9);
    map['simDisplayName'] = callLogEntry?.simDisplayName;
    map['phoneAccountId'] = callLogEntry?.phoneAccountId;
    map['comment'] = comment;
    map['commentBy'] = addedBy;
    map['path'] = path;
    map['calledFor'] = calledFor;
    map['id'] = id;
    map['clientId'] = clientId;
    map['complainPath'] = complainPath;
    map['vaccinationPath'] = vaccinationPath;
    map['salesId'] = salesId;
    map['vaccinationId'] = vaccinationId;
    map['complainId'] = complainId;
    map['isACall'] = isACall;
    map['treatmentId'] = treatmentId;
    map['treatmentPath'] = treatmentPath;
    map['dateTime'] = dateTime ?? DateTime.now().microsecondsSinceEpoch;
    map['addedByName'] = addedByName;
    map['addedById'] = addedById;
    map['toDoctorId'] = toDoctorId;
    return map;
  }

  factory Log.fromJson({required Map<dynamic, dynamic> map}) {
   bool isACall =  map['isACall'] ?? false;
    return Log(
      addedBy: map['commentBy'],
      comment: map['comment'],
      path: map['path'],
      calledFor:  map['calledFor'],
      callLogEntry: isACall ?
          CallLogEntry.fromMap(map) : null,
      id: map['id'],
      clientId: map['clientId'],
      vaccinationPath : map['vaccinationPath'],
      complainPath : map['complainPath'],
      salesId: map['salesId'],
      vaccinationId : map['vaccinationId'],
      complainId : map['complainId'],
      treatmentId: map['treatmentId'] ,
      treatmentPath: map['treatmentPath'] ,
      isACall:  isACall,
      dateTime: map['dateTime'],
      addedById:  map['addedById'],
      addedByName: map['addedByName'],
      toDoctorId:  map['toDoctorId'],

    );
  }

  Widget getTitle(){
    Widget title= Text('');
    if(callLogEntry != null){
      title = Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Call : ${callLogEntry!.number!} : ${callLogEntry!.duration!} Sec'),
          Text('comment : ${comment ?? 'No comments'}')
        ],
      );
      if(complainId != null){
        title =Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Complain Call : ${callLogEntry!.number!} : ${callLogEntry!.duration!} Sec'),
          ],
        );
      }

      if(vaccinationId!=null){
        title = Text('Vaccination Call : ${callLogEntry!.number!} : ${callLogEntry!.duration!} Sec');
      }
      if(treatmentId!=null){
        title = Text('Treatment Call : ${callLogEntry!.number!} : ${callLogEntry!.duration!} Sec');
      }
    }


    return title;

  }
}
