
import '../../constants.dart';
import '../../models/complain/Complain.dart';
import 'complain_paths.dart';
import 'other_paths.dart';

List<String> timeLinePaths({
  required String clientId,
  Complain? complain,
  required String petId,
}) {
  if (complain != null) {
    return (complainSubPaths(
        clientId: clientId,
        complainStatus: ComplainStatus.values[complain.status!],
        petId: petId,
        complainId: complain.id!,
        complainSub: ComplainSub.timeLine)
      ..addAll(complainSubPaths(
          clientId: clientId,
          complainStatus: ComplainStatus.all,
          petId: petId,
          complainId: complain.id!,
          complainSub: ComplainSub.timeLine))
      ..addAll(petPaths(clientId: clientId).map((e) => '$e/$petId/timeLine').toList()));
  } else {
    return petPaths(clientId: clientId).map((e) => '$e/$petId/timeLine').toList();
  }
}

Map<String, dynamic> updateTimeLineJson({
  required String clientId,
  Complain? complain,
  required String petId,
  required String timeLineId,
  List<String?>? variables,
  required List<dynamic> json,
}) {
  return pathListToUpdatableMap(
      id: timeLineId,
      variables: variables,
      updatingValue: json,
      pathList: timeLinePaths(clientId: clientId , petId: petId , complain: complain));
}