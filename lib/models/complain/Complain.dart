

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';

import 'package:string_extensions/string_extensions.dart';

import '../../screens/edit_screens/edit_treatment_screen.dart';
import '../../utils/tiny_space.dart';
import '../../utils/utils.dart';
import '../../widgets/text_small_title.dart';
import '../Weight.dart';
import '../client_model.dart';
import '../log.dart';
import 'FirstInspection.dart';
import 'DifferentialDiagnosis.dart';

import 'TestReports.dart';
import 'Treatment.dart';

/// firstInspection : {"id":"asdasdsa","organSystem":{"id":"dfdfsd","name":"skeltal","path":"dffsdf","results":"hghgj,dfsdfdf,dfsf"},"path":"sdasdsd","staffMember":"fdfdfs","temperature":102.5}
/// differentialDiagnosis : {"comment":"asds","id":"cvcvcxvc","name":"TF","path":"cxvvxcvc"}
/// followUp : {"id":"dfsfd","logs":{"id":"dfsdf","path":"eefsdf"},"name":"dfsdf","status":"pending"}
/// id : "dfdfsf"
/// log : {"id":"sda","path":"jknhjk"}
/// path : "dfdsfdfsdf"
/// startedDateTime : 54545
/// status : "ongoing"
/// testReports : {"id":"sfdfgd","image":{"id":"xcz","path":"xvxv"},"name":"fgdf"}
/// treatment : {"charges":514545,"dateTime":5454545,"diagnosisDeviations":{"disease":{"id":"fgfg","path":"sdfsdf"}},"drug":{"comment":"dfsds","doze":"vxcv","id":"dfsdf","name":"Amox","path":"dsfsd"},"id":"dfdsf","nextTreatnebtDateTime":454545,"path":"fdsdsd"}

class Complain {
  FirstInspection? firstInspection;
  List<DifferentialDiagnosis?>? differentialDiagnosisList;

  String? clientID;
  String? petId;
  String? id;
  List<Log?>? logList;
  String? path;
  int? startedDateTime;
  int? status;
  Weight? weight;
  List<TestReports?>? testReportsList;
  List<Treatment?>? treatmentList;
  int? nextComingDate;
  String? nextCallingDate;
  String? petName;
  String? clientName;
bool ? oldComplain;
String ? comment;
  //ClientModel ? client;

  Complain(
      {this.firstInspection,
      this.differentialDiagnosisList,
      required this.petId,
      required this.nextCallingDate,
      this.nextComingDate,
      this.id,
      this.logList,
      this.path,
      this.startedDateTime,
      this.status,
      this.testReportsList,
      this.treatmentList,
      this.weight,
      required this.clientID,
      required this.petName,
      required this.clientName,
        this.oldComplain = false,
        this.comment,
      // required this.client,
      });

  Complain.fromJson(dynamic json) {
    List<DifferentialDiagnosis> _differentialDiagnosisList = [];
    //differentialDiagnosis
    //differentialDiagnosis
    print(json['differentialDiagnosis']);
    if (json['differentialDiagnosis'] != null) {
      Map<dynamic, dynamic> _map =
          json['differentialDiagnosis'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _differentialDiagnosisList
              .add(DifferentialDiagnosis.fromJson(element));
        },
      );
      if (_differentialDiagnosisList.length > 1) {
        _differentialDiagnosisList.sort((a, b) {
          return ((a.order ?? 0) - (b.order ?? 0));
        });
      }
      differentialDiagnosisList = _differentialDiagnosisList;
    }

    List<TestReports> _testReportsList = [];
    if (json['testReports'] != null) {
      Map<dynamic, dynamic> _map = json['testReports'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _testReportsList.add(TestReports.fromJson(element));
        },
      );
      testReportsList = _testReportsList;
    }

    List<Log> _logList = [];
    if (json['logs'] != null) {
      Map<dynamic, dynamic> _map = json['logs'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _logList.add(Log.fromJson(map: element));
        },
      );
      logList = _logList;
    }

    List<Treatment> _treatmentList = [];
    if (json['treatments'] != null) {
      Map<dynamic, dynamic> _map = json['treatments'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _treatmentList.add(Treatment.fromJson(element));
        },
      );
      treatmentList = _treatmentList;
    }
    id = json['id'];
    petId = json['petId'];
    oldComplain = json['oldComplain'];
    petName = json['petName'];
    clientID = json['clientID'];
    path = json['path'];
    clientName = json['clientName'];
    startedDateTime = json['startedDateTime'];
    nextCallingDate = json['nextCallingDate'].toString();
    nextComingDate = json['nextComingDate'];
    status = json['status'];
    comment = json['comment'];
    firstInspection = json['firstInspection'] != null
        ? FirstInspection.fromJson(json['firstInspection'])
        : null;
    weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
    // client = json['client'] != null ? ClientModel.fromJson(json['client']) : null;
  }

  Complain copyWith({
    FirstInspection? firstInspection,
    List<DifferentialDiagnosis?>? differentialDiagnosisList,
    String? id,
    Weight? weight,
    String? clientId,
    List<Log?>? logList,
    String? path,
    String? petId,
    int? startedDateTime,
    String? nextCallingDate,
    int? status,
    int? nextComingDate,
    List<TestReports?>? testReportsList,
    List<Treatment?>? treatmentList,
    String? petName,
    ClientModel? client,
    String? clientName,
    bool? oldComplain,
    String ? comment,
  }) =>
      Complain(
        firstInspection: firstInspection ?? this.firstInspection,
        differentialDiagnosisList:
            differentialDiagnosisList ?? this.differentialDiagnosisList,
        nextCallingDate: nextCallingDate ?? this.nextCallingDate,
        nextComingDate: nextComingDate ?? this.nextComingDate,
        id: id ?? this.id,
        logList: logList ?? this.logList,
        path: path ?? this.path,
        clientID: clientID ?? this.clientID,
        startedDateTime: startedDateTime ?? this.startedDateTime,
        status: status ?? this.status,
        testReportsList: testReportsList ?? this.testReportsList,
        treatmentList: treatmentList ?? this.treatmentList,
        weight: weight ?? this.weight,
        petId: petId ?? this.petId,
        petName: petName ?? this.petName,
        clientName: clientName ?? this.clientName,
        oldComplain: oldComplain ?? this.oldComplain,
          comment: comment ?? this.comment
        // client: client ?? this.client
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    Map<String, dynamic> treatmentMap = {};

    if (treatmentList != null && treatmentList!.isNotEmpty) {
      for (var element in treatmentList!) {
        treatmentMap[element!.id!] = element.toJson();
      }
      map['treatments'] = treatmentMap;
    }
    Map<String, dynamic> differentialDiagnosisMap = {};

    if (differentialDiagnosisList != null && differentialDiagnosisList!.isNotEmpty) {
      for (var element in differentialDiagnosisList!) {
        differentialDiagnosisMap[element!.id!] = element.toJson();
      }
      map['differentialDiagnosis'] = differentialDiagnosisMap;
    }

    if (firstInspection != null) {
      map['firstInspection'] = firstInspection?.toJson();
    }
    if (weight != null) {
      map['weight'] = weight?.toJson();
    }
    // if (client != null) {
    //   map['client'] = client?.toJson();
    // }
    map['clientID'] = clientID.toString();
    map['petId'] = petId.toString();
    map['nextComingDate'] = nextComingDate;
    map['id'] = id.toString();
    map['path'] = path;
    map['startedDateTime'] = startedDateTime;
    map['nextCallingDate'] = nextCallingDate;
    map['status'] = status;
    map['petName'] = petName;
    map['clientName'] = clientName;


    map['oldComplain'] = oldComplain;
    map['comment'] = comment;
    return map;
  }

  String getTitle({bool withPetName = true}) {
    String title = withPetName ? '${petName ?? 'No Pet Name'} > ' : '';

    if (differentialDiagnosisList != null &&
        differentialDiagnosisList!.isNotEmpty) {
      return '$title ${differentialDiagnosisList!.map((e) => e!.name).toList().join(', ')}';
    } else {
      return title;
    }
  }

  Widget getFirstInspectionSummery() {
    Text summery = Text('');
    late Row row;
    List<TableRow> widgetList = [];
    if (firstInspection != null) {
      if (firstInspection!.organSystemInspectionsList != null) {
        firstInspection!.organSystemInspectionsList!.forEach(
          (element) {
            if (element!.results!
                .where((element) => element!.isSelected == true)
                .toList()
                .isNotEmpty) {
              widgetList = widgetList +
                  [
                    TableRow(
                      children: [
                        Text(
                          element.organSystem ?? 'No name',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),

                        Table(
                          children: element.results!
                              .where((element) => element!.isSelected == true)
                              .map((e) => TableRow(
                                    children: [
                                      Text(e!.name ?? 'No Name'),
                                      Text(e.comment ?? ''),
                                    ],
                                  ))
                              .toList(),
                        ),
                        // FittedBox(child: Text(element.results!)),
                      ],
                    ),
                  ];
            }
            // summery = summery+element!.name!+ ' - '+summery+element.results! +' ';
          },
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'First Inspection Details',
            style: Get.textTheme.headline6,
          ),
          TinySpace(),
          Table(
            border: TableBorder(horizontalInside: BorderSide(width: 0.5)),
            children: widgetList,
          ),
        ],
      ),
    );
  }

  Widget getTreatmentSummery() {
    return treatmentList != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: const TableBorder(
                  top: BorderSide(width: 1),
                  left: BorderSide(width: 1),
                  right: BorderSide(width: 1),
                  bottom: BorderSide(width: 1),
                  verticalInside: BorderSide(width: 0.2),
                  horizontalInside: BorderSide(width: 0.2)),
              children: [
                TableRow(children: [
                  Center(child: TextSmallTitle('Date')),
                  Center(child: TextSmallTitle('Drugs')),
                  Center(child: TextSmallTitle('Charges')),
                  Center(child: TextSmallTitle('')),
                ])
              ]..addAll(treatmentList!
                  .map((e) => TableRow(
                        children: [
                          Center(
                              child: Text(e!.dateTime!= null ? dateIntToFormattedDate(
                                  fromMicroSecondsSinceEpoch: e.dateTime! ): 'No Data')),
                          Center(
                              child: Text(
                            e.drugList!.map((e) => e!.name).toList().join(', '),
                            overflow: TextOverflow.ellipsis,
                          )),
                          Center(child: Text(e.charges.toString())),
                          Center(
                            child: IconButton(
                                onPressed: () {
                                  Get.to(EditTreatmentScreen(
                                    treatment: e,
                                  ));
                                },
                                icon: Icon(Icons.arrow_circle_right_outlined)),
                          )
                        ],
                      ))
                  .toList()),
            ),
          )
        : Container(
            child: Center(child: Text('Still No Treatments')),
          );
  }

  Map<DateTime, List<Log?>> getLogsDayByDay() {
    final groups = groupBy(logList!, (Log? log) {
      return DateUtils.dateOnly(
          DateTime.fromMicrosecondsSinceEpoch(log!.id!.toInt()!));
    });

    return groups;
  }

  List<Widget> getLogDayByDayWidgets() {
    logList!.sort(
      (a, b) => b!.dateTime! - a!.dateTime!,
    );
    int days = DateTime.now()
        .difference(
            DateTime.fromMicrosecondsSinceEpoch(logList!.last!.dateTime!))
        .inDays;

    return List.generate(
        days,
        (index) => GFBadge(
              child: Text(getLogsDayByDay()[DateUtils.dateOnly(
                      DateTime.now().subtract(Duration(days: index)))]!
                  .length.toString()),
            ));
  }
}
