import '../../constants.dart';
import '../../models/Vaccination.dart';

enum VaccinationStatus { notCalled, called, dismissed, all }

List<String> vaccinationPaths(
    {required String clientId,
    required String petId,
    required VaccinationStatus vaccinationStatus}) {
  return [
    'pets/$petId/vaccinations/${vaccinationStatus.name}',
    '$doctorPath/clients/real/$clientId/pets/$petId/vaccinations/${vaccinationStatus.name}',
    '$doctorPath/vaccinations/'
        'clients/real/$clientId/pets/$petId/vaccinations/${vaccinationStatus.name}',
    'vaccinations/${vaccinationStatus.name}',
  ];
}

Map<String, dynamic> swapVaccinationJson(
    {required Vaccination vaccination,
    required VaccinationStatus from,
    required VaccinationStatus to}) {
  return updateVaccinationJson(
      petId: vaccination.petId!,
      clientId: vaccination.clientId!,
      json: [vaccination.toJson()],
      vaccinationId: vaccination.id!,
      vaccinationStatus: to)
    ..addAll(updateVaccinationJson(
        petId: vaccination.petId!,
        clientId: vaccination.clientId!,
        json: [{}],
        vaccinationId: vaccination.id!,
        vaccinationStatus: from)
      ..addAll(updateVaccinationJson(
          petId: vaccination.petId!,
          clientId: vaccination.clientId!,
          json: [to.index],
          vaccinationId: vaccination.id!,
          variables: ['vaccinationStatus'],
          vaccinationStatus: VaccinationStatus.all)));
}

Map<String, dynamic> updateVaccinationJson({
  required String petId,
  required String clientId,
  List<String?>? variables,
  required List<dynamic> json,
  required String vaccinationId,
  required VaccinationStatus vaccinationStatus,
}) {
  return pathListToUpdatableMap(
      id: vaccinationId,
      variables: variables,
      updatingValue: json,
      pathList: vaccinationPaths(
          clientId: clientId,
          petId: petId,
          vaccinationStatus: vaccinationStatus));
}

Map<String, dynamic> addVaccinationJson({
  required String petId,
  required String clientId,
  List<String?>? variables,
  required List<dynamic> json,
  required String vaccinationId,
  required VaccinationStatus vaccinationStatus,
}) {
  return pathListToUpdatableMap(
      id: vaccinationId,
      variables: variables,
      updatingValue: json,
      pathList: vaccinationPaths(
          clientId: clientId,
          petId: petId,
          vaccinationStatus: vaccinationStatus))
    ..addAll(pathListToUpdatableMap(
        id: vaccinationId,
        updatingValue: json,
        variables: variables,
        pathList: vaccinationPaths(
            clientId: clientId,
            petId: petId,
            vaccinationStatus: VaccinationStatus.all)));
}
