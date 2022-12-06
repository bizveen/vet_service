
import 'Scannig.dart';
import 'log.dart';

/// DeleviryMode : ""
/// bleedingStartedDate : 4544
/// bleedingStoppedDate : 4544
/// crossingDates : 4
/// deliveryDate : ""
/// logs : ""
/// noOfChildren : ""
/// scannigs : {"comment":"","date":"","id":"","path":""}

class PregnancyCycle {
  PregnancyCycle({
      this.deleviryMode, 
      this.bleedingStartedDate, 
      this.bleedingStoppedDate, 
      this.crossingDates, 
      this.deliveryDate, 
      this.logs, 
      this.noOfChildren, 
      this.scannigs,});

  PregnancyCycle.fromJson(dynamic json) {

    List<Log> _logList = [];
    if (json['logs'] != null) {
      Map<dynamic, dynamic> _map = json['logs'] as Map<dynamic, dynamic>;

      _map.forEach(
            (key, element) {
          _logList.add(Log.fromJson(map :element));
        },
      );
    }

    List<Scannig> _scanningList = [];
    if (json['scannings'] != null) {
      Map<dynamic, dynamic> _map = json['scannings'] as Map<dynamic, dynamic>;

      _map.forEach(
            (key, element) {
          _scanningList.add(Scannig.fromJson(element));
        },
      );
    }


    deleviryMode = json['DeleviryMode'];
    bleedingStartedDate = json['bleedingStartedDate'];
    bleedingStoppedDate = json['bleedingStoppedDate'];
    crossingDates = json['crossingDates'];
    deliveryDate = json['deliveryDate'];
    logs = _logList;
    noOfChildren = json['noOfChildren'];
    scannigs = _scanningList;
  }
  String? deleviryMode;
  int? bleedingStartedDate;
  int? bleedingStoppedDate;
  int? crossingDates;
  String? deliveryDate;
  List<Log?>? logs;
  String? noOfChildren;
  List<Scannig?>? scannigs;
PregnancyCycle copyWith({  String? deleviryMode,
  int? bleedingStartedDate,
  int? bleedingStoppedDate,
  int? crossingDates,
  String? deliveryDate,
  List<Log?>? logs,
  String? noOfChildren,
  List<Scannig?>? scannigs,
}) => PregnancyCycle(  deleviryMode: deleviryMode ?? this.deleviryMode,
  bleedingStartedDate: bleedingStartedDate ?? this.bleedingStartedDate,
  bleedingStoppedDate: bleedingStoppedDate ?? this.bleedingStoppedDate,
  crossingDates: crossingDates ?? this.crossingDates,
  deliveryDate: deliveryDate ?? this.deliveryDate,
  logs: logs ?? this.logs,
  noOfChildren: noOfChildren ?? this.noOfChildren,
  scannigs: scannigs ?? this.scannigs,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DeleviryMode'] = deleviryMode;
    map['bleedingStartedDate'] = bleedingStartedDate;
    map['bleedingStoppedDate'] = bleedingStoppedDate;
    map['crossingDates'] = crossingDates;
    map['deliveryDate'] = deliveryDate;
    map['noOfChildren'] = noOfChildren;

    return map;
  }

}