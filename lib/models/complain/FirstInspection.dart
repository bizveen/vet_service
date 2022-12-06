import 'OrganSystemInspections.dart';

/// id : "asdasdsa"
/// organSystem : {"id":"dfdfsd","name":"skeltal","path":"dffsdf","results":"hghgj,dfsdfdf,dfsf"}
/// path : "sdasdsd"
/// staffMember : "fdfdfs"
/// temperature : 102.5

class FirstInspection {
  String? id;
  List<OrganSystemInspections?>? organSystemInspectionsList;
  String? path;
  String? staffMember;
  String? temperature;

  FirstInspection({
    this.id,
    this.organSystemInspectionsList,
    this.path,
    this.staffMember,
    this.temperature,
  });

  FirstInspection.fromJson(dynamic json) {
    id = json['id'];
    List<OrganSystemInspections> _organSystemsList = [];
    if (json['organSystemInspections'] != null) {
      Map<dynamic, dynamic> _map =
          json['organSystemInspections'] as Map<dynamic, dynamic>;

      _map.forEach(
        (key, element) {
          _organSystemsList.add(OrganSystemInspections.fromJson(element));
        },
      );
      organSystemInspectionsList = _organSystemsList;
    }

    path = json['path'];
    staffMember = json['staffMember'];
    temperature = json['temperature'];
  }

  FirstInspection copyWith({
    String? id,
    List<OrganSystemInspections?>? organSystemList,
    String? path,
    String? staffMember,
    String? temperature,
  }) =>
      FirstInspection(
        id: id ?? this.id,
        organSystemInspectionsList:
            organSystemList ?? this.organSystemInspectionsList,
        path: path ?? this.path,
        staffMember: staffMember ?? this.staffMember,
        temperature: temperature ?? this.temperature,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    Map<String, Map<String, dynamic>> organSystemsMap = {};

    for (int i = 0; i < organSystemInspectionsList!.length; i++) {
      organSystemsMap[organSystemInspectionsList![i]!.id!] =
          organSystemInspectionsList![i]!.toJson();
    }
    if (organSystemInspectionsList != null) {
      map['organSystemInspections'] = organSystemsMap;
    }
    map['path'] = path;
    map['staffMember'] = staffMember;
    map['temperature'] = temperature;
    return map;
  }



}
