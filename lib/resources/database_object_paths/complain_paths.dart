import '../../constants.dart';

enum ComplainStatus { active, completed, dismissed , all}

List<String> complainPaths(
    {required String clientId,
      required String petId,
      required ComplainStatus complainStatus}) {

  return [
    'pets/$petId/complains/${complainStatus.name}',
    '$doctorPath/clients/real/$clientId/pets/$petId/complains/${complainStatus.name}',
    '$doctorPath/pets/$petId/complains/${complainStatus.name}',
    'clients/real/$clientId/pets/$petId/complains/${complainStatus.name}',
    '$doctorPath/complains/${complainStatus.name}',
    'complains/${complainStatus.name}'
  ];
}

enum ComplainSub { treatments, firstInspections, differentialDiagnosis , timeLine}

List<String> complainSubPaths({
  required String clientId,
  required String petId,
  required String complainId,
  required ComplainSub complainSub,
  required ComplainStatus complainStatus,
}) {

  return complainPaths(clientId: clientId, petId: petId, complainStatus: complainStatus)
      .map((e) => '$e/$complainId/${complainSub.name}').toList();
  // return [
  //   'pets/$petId/complains/${complainStatus.name}/$complainId/${complainSub.name}',
  //   '$doctorPath/clients/real/$clientId/pets/$petId/complains/${complainStatus.name}/$complainId/${complainSub.name}',
  //   '$doctorPath/pets/$petId/complains/${complainStatus.name}/$complainId/${complainSub.name}'
  //   'clients/real/$clientId/pets/$petId/complains/${complainStatus.name}/$complainId/${complainSub.name}',
  //   '$doctorPath/complains/${complainStatus.name}/$complainId/${complainSub.name}',
  //   'complains/${complainStatus.name}/$complainId/${complainSub.name}'
  // ];
}

Map<String, dynamic> updateComplainJson(
    {required String petId,
      required String clientId,
      List<String?>? variables,
      required List<dynamic> json,
      required String complainId,
      required ComplainStatus complainStatus}) {
  return pathListToUpdatableMap(
      id: complainId,
      variables: variables,
      updatingValue: json,
      pathList: complainPaths(
          clientId: clientId, petId: petId, complainStatus: complainStatus));
}



Map<String, dynamic> addComplainJson(
    {required String petId,
      required String clientId,
      List<String?>? variables,
      required List<dynamic> json,
      required String complainId,
      required ComplainStatus complainStatus}) {
  return pathListToUpdatableMap(
      id: complainId,
      variables: variables,
      updatingValue: json,
      pathList: complainPaths(
          clientId: clientId, petId: petId, complainStatus: complainStatus))..addAll(
    pathListToUpdatableMap(
      id: complainId,
      variables: variables,
      updatingValue: json,
    pathList: complainPaths(
        clientId: clientId, petId: petId, complainStatus: ComplainStatus.all)
    )
  );
}








Map<String, dynamic> swapComplain(
    {required String petId,
      required String clientId,
      required String complainId,
      required dynamic json,
      required ComplainStatus from,
      required ComplainStatus to}) {
  return updateComplainJson( // adding Complain
      petId: petId,
      clientId: clientId,
      json: [json],
      complainId: complainId,
      complainStatus: to)
    ..addAll(
        updateComplainJson( // removing complain
        petId: petId,
        clientId: clientId,
        json: [{}],
        complainId: complainId,
        complainStatus: from)
      ..addAll(
        updateComplainJson( // updating status value of all Complains
        petId: petId,
        clientId: clientId,
        json: [to.index],
        complainId: complainId,
        complainStatus: ComplainStatus.all,
          variables: ['status']
        )));
}



Map<String, dynamic> updateComplainSubJson(
    {
      required String petId,
      required String clientId,
      List<String?>? variables,
      required List<dynamic> json,
      required String id,
      required String complainId,
      required ComplainSub complainSub,
      required ComplainStatus complainStatus}) {
  return pathListToUpdatableMap(
      id: id,
      variables: variables,
      updatingValue: json,
      pathList: complainSubPaths(
          clientId: clientId,
          petId: petId,
          complainId: complainId,
          complainSub: complainSub,
          complainStatus: complainStatus));
}
