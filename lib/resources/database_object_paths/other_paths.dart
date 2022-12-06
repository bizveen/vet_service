

import '../../constants.dart';
import '../../models/client_model.dart';

//List<String?>? clientPaths = ['clients', '$doctorPath/clients'];

List<String> clientPaths({required ClientStatus clientStatus}) {
  return [
    'clients/${clientStatus.name}',
    '$doctorPath/clients/${clientStatus.name}'
  ];
}


List<String> petPaths({required String clientId}) {
  return [
    'pets',
    '$doctorPath/clients/real/$clientId/pets',
    '$doctorPath/pets',
    'clients/real/$clientId/pets'
  ];
}

List<String> petWeightPaths ({required String clientId, required String petId}){
  return petPaths(clientId: clientId).map((e) => '$e/$petId/weight').toList();
}


Map<String, dynamic> updateWeightJson({
  required String petId,
  required String clientId,
  required String weightId,
  List<String?>? variables,
  required List<dynamic> json,
}) {
  return pathListToUpdatableMap(
      id: weightId,
      variables: variables,
      updatingValue: json,
      pathList: petWeightPaths(clientId: clientId,petId: petId));
}


List<String> contactPaths({required String clientId, }) {
  return [
    'contacts',
    '$doctorPath/clients/real/$clientId/contacts/',
    'clients/real/$clientId/contacts/',
        '$doctorPath/contacts'
  ];
}

Map<String, dynamic> updateClientJson(

    {
      required String clientId,
      required ClientStatus clientStatus,
      List<String?>? variables,
      required List<dynamic> json}) {
  return pathListToUpdatableMap(
      id: clientId,
      variables: variables,
      pathList: clientPaths(clientStatus: clientStatus),
      updatingValue: json);
}

Map<String, dynamic> updatePetJson({
  required String petId,
  required String clientId,
  List<String?>? variables,
  required List<dynamic> json,
}) {
  return pathListToUpdatableMap(
      id: petId,
      variables: variables,
      updatingValue: json,
      pathList: petPaths(clientId: clientId));
}

Map<String, dynamic> updateContactJson({
  required String contactId,
  required String clientId,
  List<String?>? variables,
  required List<dynamic> json,
}) {
  return pathListToUpdatableMap(
      id: contactId,
      variables: variables,
      updatingValue: json,
      pathList: contactPaths(clientId: clientId));
}