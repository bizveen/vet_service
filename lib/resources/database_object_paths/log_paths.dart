
import '../../constants.dart';
import '../../models/Vaccination.dart';
import '../../models/log.dart';

enum LogType { vaccination, complain, sale, visit, other}
enum CallType{vaccination, complain , other}

List<String> logPaths({
  required String clientId,
  String? vaccinationId,
  String? complainId,
   String ? petId,
  required LogType logType}) {
  switch (logType) {
    case LogType.vaccination:
      return [
        'clients/real$clientId/logs',
        '$doctorPath/clients/real/$clientId/logs',
        'clients/real/$clientId/pets/$petId/logs',
        'clients/real/$clientId/pets/$petId/vaccinations/all/$vaccinationId/logs',
        'vaccinations/all/$vaccinationId/logs',
        'pets/$petId/vaccinations/all/$vaccinationId/logs',
        'pets/$petId/logs',
        'logs'
      ];
      break;
    case LogType.complain:
      return [
        'clients/real/$clientId/logs',
        'clients/real/$clientId/pets/$petId/logs',
        'clients/real/$clientId/pets/$petId/complains/all/$complainId/logs',
        'complains/all/$complainId/logs',
        'pets/$petId/complains/all/$complainId/logs',
        'pets/$petId/logs',
        'logs'
      ];
      break;

    case LogType.sale:
      return [
        'clients/real/$clientId/logs',
        'logs'

      ];
      break;
    case LogType.visit:
      return [
        'clients/real/$clientId/logs',
        'logs'
      ];
      break;

    case LogType.other:
      return [
        'clients/real/$clientId/logs',
        'logs'
      ];
      break;


  }

}

Map<String, dynamic> updateLogJson(
    {required Log log,
      String ?petId,
      required String clientId,
      required LogType logType,
      String? vaccinationId,
      String? complainId,
      List<String?>? variables,
      required List<dynamic> json,

     }) {
  return pathListToUpdatableMap(
      id: log.id!,
      variables: variables,
      updatingValue: json,
      pathList:
      logPaths(
          clientId: clientId, petId: petId, logType: logType ,
          vaccinationId: vaccinationId, complainId: complainId, )
     );
}


