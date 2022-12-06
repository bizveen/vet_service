
import 'package:equatable/equatable.dart';

import 'organ_system_inspections_result.dart';

class OrganSystemInspections extends Equatable{
  OrganSystemInspections({
      this.id, 
      this.name, 
      this.path, 
      this.results,
    required this.organSystem
  });

  OrganSystemInspections.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    organSystem = json['organSystem'];
    List<OrganSystemInspectionsResult?> _resultList = [];
    if (json['results'] != null) {
      Map<dynamic, dynamic> _map = json['results'] as Map<dynamic, dynamic>;

      _map.forEach(
            (key, element) {
          _resultList.add(OrganSystemInspectionsResult.fromJson(element, key));
        },
      );
      results = _resultList;
    }



  }
  String? id;
  String? name;
  String? path;
  String? organSystem;
  List<OrganSystemInspectionsResult?>?  results;

OrganSystemInspections copyWith({  String? id,
  String? name,
  String? path,
  String? organSystem,
  List<OrganSystemInspectionsResult?>?  results,
}) => OrganSystemInspections(  id: id ?? this.id,
  name: name ?? this.name,
  path: path ?? this.path,
  results: results ?? this.results,
  organSystem: organSystem ?? this.organSystem,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['path'] = path;
    map['organSystem'] = organSystem;
    Map <String , dynamic> resultsMap = {};

    if(results!=null){
      for (var element in results!) { resultsMap[element!.id!] =element.toJson() ;}
      map['results'] = resultsMap;
    }

    return map;
  }

  @override

  List<Object?> get props => [name];


  List<OrganSystemInspectionsResult?>? getResults (){

   return  results!.where((element) => element!.isSelected == true).toList();}


}