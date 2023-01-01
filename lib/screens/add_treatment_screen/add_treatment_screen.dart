
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vet_service/resources/firebase_firestore_methods.dart';
import 'package:vet_service/screens/add_treatment_screen/add_treatment_screen_controller.dart';
import '../../constants.dart';
import 'dart:developer' as dlog;
import '../../models/client_model.dart';
import '../../models/complain/Complain.dart';
import '../../models/complain/Drug.dart';
import '../../models/complain/Treatment.dart';
import '../../models/log.dart';
import '../../resources/database_object_paths/complain_paths.dart';
import '../../resources/database_object_paths/log_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../resources/sales_methods.dart';
import '../../utils/utils.dart';
import '../../widgets/date_picker_widget.dart';
import '../../widgets/text_field_x.dart';
import 'local_widgets/drop_down_drug_list_from_database_widget_muti_select.dart';

class AddTreatmentScreen extends GetView<AddTreatmentScreenController> {
  Complain complain;

  AddTreatmentScreen({Key? key, required this.complain}) : super(key: key);


  TextEditingController chargesController = TextEditingController();
  List<Drug?>? _drugsList = [];

  DateTime? nextCommingDate;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a treatment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropDownDrugListFromDatabaseWidgetMultiSelect(
              key: GlobalKey(debugLabel: "Drugs List"),

                databasePath: '$doctorPath/drugs',
                databaseVariable: 'name',
                hintText: 'Select Given Drugs',

                onConfirm: (values) {

                    controller.selectedDrugsList.value = values!;


                }),
            TextFieldX(
              label: 'Charges',
              controller: chargesController,
            ),
            TextFieldX(label: 'Comment'),
            DatePickerWidget(
              buttonText: 'Select',
              pickedDate: (date) {
                nextCommingDate = date;
              },
              datePrefix: 'Next Coming Date',
            ),
            Row(
              children: [
                TextButton(
                    // Save Button
                    onPressed: () async {
                      String treatmentId = const Uuid().v1();
                     // _drugsList!.forEach((element) { Get.log(element!.toJson().toString());});
                      Treatment treatment = Treatment(
                        complainId: complain.id!,
                          petId: complain.petId,
                          complainPath: complain.path,
                          id: treatmentId,
                          path:
                              '${complain.path}/treatments/$treatmentId',
                          dateTime: DateTime.now().microsecondsSinceEpoch,
                          charges: int.parse(chargesController.text.trim() == ''
                              ? '0'
                              : chargesController.text.trim()),
                          drugList: controller.selectedDrugsList.value,
                          // drugList: _drugsList,
                          nextTreatmentDateTime:
                              nextCommingDate?.microsecondsSinceEpoch,
                          followupIndex: 'started_',
                        treatmentTitle: '${complain.petName} > ${complain.differentialDiagnosisList!= null ? complain.differentialDiagnosisList![0]!.name! : 'No Title'}'
                      );
                      String logId = dateTimeDescender(dateTime: DateTime.now())
                          .toString();

                      Log log = Log(
                          isACall: false,
                          addedBy: FirebaseAuth.instance.currentUser!.email!,
                          id: logId,
                          path: '$doctorPath/logs/$logId',
                          treatmentId: treatment.id,
                          treatmentPath: treatment.path,
                          comment:
                              '${complain.petName} > A treatment added (${treatment.drugList!.map((e) => e!.name).toList().join(',')})');
                      // await SalesMethods(.
                      //         clientId: widget.complain.clientID!,
                      //         treatment: treatment)
                      //     .createASale();

                      // DataSnapshot snap = await FirebaseDatabaseMethods()
                      //     .reference(
                      //         path:
                      //             '$doctorPath/clients/${widget.complain.clientID}/currentActiveCaseId')
                      //     .get();

                      //if client is not activated - creating the sales object first

                     await FirebaseFirestoreMethods().firestore.collection('clients').doc(complain.clientID!).update(
                         {
                           "pets.${complain.petId}.complains.${complain.id}.treatments.$treatmentId" : treatment.toJson()
                         });



                      // await SalesMethods(
                      //   clientStatus: ClientStatus.real,
                      //         clientId: complain.clientID!,
                      //         treatment: treatment)
                      //     .createASale();
                      // treatment.complainPath != null
                      //     ? FirebaseDatabaseMethods().updateBatch({
                      //         treatment.path!: treatment.toJson(),
                      //
                      //         '$doctorPath/sales/${snap.value}/treatments/${treatment.id}':
                      //             treatment.toJson(),
                      //         '$doctorPath/complainFollowUps/${widget.complain.id}/treatments/${treatment.id}':
                      //             treatment.toJson(),
                      //
                      //         //complain next coming date updating
                      //         '${treatment.complainPath!}/nextComingDate':
                      //             treatment.nextTreatmentDateTime,
                      //         '$doctorPath/complainFollowUps/${widget.complain.id}/status':
                      //             'current',
                      //       })
                      //     : FirebaseDatabaseMethods().updateBatch({
                      //         treatment.path!: treatment.toJson(),
                      //         '$doctorPath/sales/${snap.value}/treatments/${treatment.id}':
                      //             treatment.toJson(),
                      //         '$doctorPath/complainFollowUps/${widget.complain.id}/treatments/${treatment.id}':
                      //             treatment.toJson()
                      //       });

                      Get.back();
                      controller.selectedDrugsList.value.clear();
                    },
                    child: const Text('Save')),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
