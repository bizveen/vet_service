import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../constants.dart';
import '../../../models/Pet.dart';
import '../../../models/Vaccination.dart';
import '../../../models/Vaccine.dart';
import '../../../models/client_model.dart';
import '../../../models/log.dart';
import '../../../resources/database_object_paths/log_paths.dart';
import '../../../resources/database_object_paths/vaccination_paths.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../../resources/firebase_storage_methods.dart';
import '../../../resources/sales_methods.dart';
import '../../../utils/utils.dart';
import '../../../widgets/container_with_border.dart';
import '../../../widgets/image_picker_widget.dart';

import 'local_widgets/search_vaccine_widget.dart';

class AddVaccinationScreen extends StatefulWidget {
  Pet pet;

  AddVaccinationScreen({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  State<AddVaccinationScreen> createState() => _AddVaccinationScreenState();
}

class _AddVaccinationScreenState extends State<AddVaccinationScreen> {
  DateFormat formatter = DateFormat('yyyy/MM/dd');
  Uint8List? _image;

  DateTime? givenDate = DateTime.now();
  DateTime? nextDate = DateTime.now().add(const Duration(days: 14));
  DateTime? nextARV = DateTime.now();

  Vaccines? givenVaccine;
  String? nextVaccine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vaccination'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImagePickerWidget(
              pickedImage: (image) {
                _image = image;
              },
            ),
            vaccineBarMethod(
              onSelect: (value) {
                givenVaccine = value;
              },
              name: 'Given Vaccine',
              selectedDateTime: (value) {
                givenDate = value;
              },
              selectedDate: givenDate ?? DateTime.now(),
            ),
            vaccineBarMethod(
              onSelect: (value) {
                nextVaccine = value.name;
              },
              name: 'Next Vaccine',
              selectedDateTime: (value) {
                nextDate = value;
              },
              selectedDate:
                  nextDate ?? DateTime.now().add(const Duration(days: 14)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Next ARV'),
                dateButton(
                    selectedDateTime: (dateTime) {
                      nextARV = dateTime;
                    },
                    selectedDate: nextARV)
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      String id = const Uuid().v1();
                      Vaccination vaccination = Vaccination(
                        vaccinationStatus: VaccinationStatus.notCalled.index,
                          clientId: widget.pet.clientId,
                          petId: widget.pet.id,
                          givenDate: givenDate!.microsecondsSinceEpoch,
                          nextDate: nextDate!.microsecondsSinceEpoch,
                          nextVaccination: nextVaccine,
                          nextArvDate: nextARV!.microsecondsSinceEpoch,
                          id: id,
                          givenVaccine: givenVaccine,
                          path: '${widget.pet.path}/vaccinations/$id');
                      String logId = dateTimeDescender(dateTime: DateTime.now())
                          .toString();
                      Log log = Log(
                        dateTime: DateTime.now().microsecondsSinceEpoch,
                        id: logId,
                        clientId: widget.pet.clientId,
                        vaccinationId: vaccination.id,
                        vaccinationPath: vaccination.path,
                        comment:
                            '${widget.pet.name ?? 'Pet'} - ${vaccination.givenVaccine!.name?? 'No Name'}',
                        addedBy: FirebaseAuth.instance.currentUser!.email,
                        path: '$doctorPath/logs/$logId',
                        isACall: false,
                      );

                      if (_image != null) {
                        FirebaseStorageMethods().uploadImageToStorage(
                            oneImage: true,
                            title: 'Vaccination Image',
                            addressPaths: vaccinationPaths(
                                    vaccinationStatus:
                                        VaccinationStatus.notCalled,
                                    clientId: widget.pet.clientId!,
                                    petId: widget.pet.id!)
                                .map((e) => '$e/${vaccination.id}')
                                .toList(),
                            file: _image!,
                            folderPath: '${widget.pet.path}/vaccinations/$id');
                      }

                      await FirebaseDatabaseMethods()
                          .updateBatch(addVaccinationJson(
                        vaccinationStatus: VaccinationStatus.notCalled,
                        petId: widget.pet.id!,
                        clientId: widget.pet.clientId!,
                        json: [vaccination.toJson()],
                        vaccinationId: vaccination.id!,
                      ));
                          await FirebaseDatabaseMethods()
                          .updateBatch(
                          updateLogJson(log: log, clientId: vaccination.clientId!,
                              logType: LogType.vaccination, json: [log.toJson()],
                              petId: widget.pet.id, vaccinationId: vaccination.id));
                      await SalesMethods(
                        clientStatus: ClientStatus.real,
                              clientId: widget.pet.clientId!,
                              vaccination: vaccination, )
                          .createASale();
                      Get.back();
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget vaccineBarMethod(
      {required String name,
      required Function(Vaccines) onSelect,
      required Function(DateTime) selectedDateTime,
      required DateTime selectedDate}) {
    return ContainerWithBorder(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          dateButton(
            selectedDateTime: (dateTime) {
              selectedDateTime(dateTime!);
            },
            selectedDate: selectedDate,
          ),
          Expanded(
            child: SearchVaccineWidget(
                title: name,
                onSelect: (value) {
                  onSelect(value);
                }),
          ),
        ],
      ),
    );
  }

  Widget dateButton(
      {required Function(DateTime?) selectedDateTime,
      required DateTime? selectedDate}) {
    return TextButton(
      onPressed: () async {
        DateTime? _date = await _showDatePicker(selectedDate: selectedDate);
        selectedDateTime(_date);
        setState(() {
          selectedDate = _date;
        });
      },
      child: Text(formatter.format(selectedDate!)),
    );
  }

  Future<DateTime?> _showDatePicker({DateTime? selectedDate}) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime(2005, 1, 1),
      initialDate: selectedDate ?? DateTime.now(),
      lastDate: DateTime(2050, 1, 1),
      selectableDayPredicate: (DateTime date) {
        return date != DateTime(2022, 04, 06);
      },
      fieldHintText: 'Vaccine Given Date',
      fieldLabelText: 'Given Vaccine Date',
      helpText: 'What is your Given date?',
    );
  }
}
