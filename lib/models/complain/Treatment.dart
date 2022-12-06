

import '../Disease.dart';
import 'Drug.dart';




/// charges : 514545
/// dateTime : 5454545
/// diagnosisDeviations : {"disease":{"id":"fgfg","path":"sdfsdf"}}
/// drug : {"comment":"dfsds","doze":"vxcv","id":"dfsdf","name":"Amox","path":"dsfsd"}
/// id : "dfdsf"
/// nextTreatnebtDateTime : 454545
/// path : "fdsdsd"

class Treatment {
  Treatment({
    this.charges,
    this.dateTime,
    this.diagnosisDeviations,
    this.drugList,
    this.id,
    this.nextTreatmentDateTime,
    this.path,
    this.clientId,
    required this.complainId,
    required this.petId,
    required this.complainPath,
    required this.followupIndex,
    required this.treatmentTitle,
  });

  Treatment.fromJson(dynamic json) {
    charges = json['charges'];
    complainPath = json['complainPath'];
    dateTime = json['dateTime'];
    followupIndex = json['followupIndex'];
    treatmentTitle = json['treatmentTitle'];

    List<Drug> _drugList = [];
    if (json['drugs'] != null) {
      Map<dynamic, dynamic> _map = json['drugs'] as Map<dynamic, dynamic>;
print(_map);
      _map.forEach(
        (key, element) {
         // print(element.toString());
          _drugList.add(Drug.fromJson(element));
        },
      );
    }

    // List<Disease> _diagnosisDeviations = [];
    // if (json['drugs'] != null) {
    //   Map<dynamic, dynamic> _map =
    //       json['diagnosisDeviations'] as Map<dynamic, dynamic>;
    //
    //   _map.forEach(
    //     (key, element) {
    //       _diagnosisDeviations.add(Disease.fromJson(element));
    //     },
    //   );
    // }
   // diagnosisDeviations = _diagnosisDeviations;

    drugList = _drugList;
    id = json['id'];
    nextTreatmentDateTime = json['nextTreatmentDateTime'];
    path = json['path'];
    clientId = json['clientId'];
    complainId = json['complainId'];
    petId = json['petId'];
  }

  int? charges;
  int? dateTime;
  String? clientId;
  List<Disease?>? diagnosisDeviations;
  List<Drug?>? drugList;
  String? id;
  int? nextTreatmentDateTime;
  String? path;
  String? treatmentTitle;
String? complainPath;
String? followupIndex;
String? petId;
String? complainId;


  Treatment copyWith({
    int? charges,
    int? dateTime,
    List<Disease?>? diagnosisDeviations,
    List<Drug?>? drugList,
    String? clientId,
    String? id,
    String? complainPath,
    int? nextTreatmentDateTime,
    String? followupIndex,
    String? path,
    String? treatmentTitle,
    String? petId,
    String? complainId,
  }) =>
      Treatment(
        charges: charges ?? this.charges,
        complainPath: complainPath ?? this.complainPath,
        dateTime: dateTime ?? this.dateTime,
        clientId: clientId ?? this.clientId,
        diagnosisDeviations: diagnosisDeviations ?? this.diagnosisDeviations,
        drugList: drugList ?? this.drugList,
        followupIndex: followupIndex ?? this.followupIndex,
        treatmentTitle: treatmentTitle?? this.treatmentTitle,

        id: id ?? this.id,
        nextTreatmentDateTime:
            nextTreatmentDateTime ?? this.nextTreatmentDateTime,
        path: path ?? this.path,
        complainId: complainId ?? this.complainId,
        petId: petId ?? this.petId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    Map<String, Map<String, dynamic>> drugMap = {};
    if(drugList!= null && drugList!.isNotEmpty){
    for (int i = 0; i < drugList!.length; i++) {
      drugMap[drugList![i]!.id!] = drugList![i]!.toJson();
      // {
      //   'id': drugList![i]!.id,
      //   'name': drugList![i]!.name,
      //   'status': drugList![i]!.doze,
      //   'comment': drugList![i]!.comment,
      //   'path': drugList![i]!.path,
      // };
    }}

    map['clientId'] = clientId;
    map['charges'] = charges;
    map['dateTime'] = dateTime;
    map['drugs'] = drugMap;
    map['complainPath'] = complainPath;
    map['id'] = id;
    map['nextTreatmentDateTime'] = nextTreatmentDateTime;
    map['path'] = path;
    map['followupIndex'] = followupIndex;
    map['complainId'] = complainId;
    map['petId'] = petId;

    return map;
  }

String? getTreatmentTitle(){
    return (drugList!= null && drugList!.isNotEmpty) ? drugList!.map((e) => e!.name).toList().join(', ') : 'No Drugs';
}
}
