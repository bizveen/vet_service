
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_database/firebase_database.dart';
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

class AddTreatmentScreen extends StatefulWidget {
  Complain complain;

  AddTreatmentScreen({Key? key, required this.complain}) : super(key: key);

  @override
  State<AddTreatmentScreen> createState() => _AddTreatmentScreenState();
}

class _AddTreatmentScreenState extends State<AddTreatmentScreen> {
  TextEditingController chargesController = TextEditingController();
  List<Drug?>? _drugsList = [];

  DateTime? nextCommingDate;

  @override
  void dispose() {

    super.dispose();
    chargesController.dispose();
  }

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
                databasePath: '$doctorPath/drugs',
                databaseVariable: 'name',
                hintText: 'Select Given Drugs',
                onConfirm: (values) {
                  setState(() {
                    _drugsList = values!;
                  });

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
                        complainId: widget.complain.id!,
                          petId: widget.complain.petId,
                          complainPath: widget.complain.path,
                          id: treatmentId,
                          path:
                              '${widget.complain.path}/treatments/$treatmentId',
                          dateTime: DateTime.now().microsecondsSinceEpoch,
                          charges: int.parse(chargesController.text.trim() == ''
                              ? '0'
                              : chargesController.text.trim()),
                          drugList: _drugsList,
                          // drugList: _drugsList,
                          nextTreatmentDateTime:
                              nextCommingDate?.microsecondsSinceEpoch,
                          followupIndex: 'started_',
                        treatmentTitle: '${widget.complain.petName} > ${widget.complain.differentialDiagnosisList!= null ? widget.complain.differentialDiagnosisList![0]!.name! : 'No Title'}'
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
                              '${widget.complain.petName} > A treatment added (${treatment.drugList!.map((e) => e!.name).toList().join(',')})');
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

                      await FirebaseDatabaseMethods()
                          .updateBatch(updateComplainSubJson(
                        petId: widget.complain.petId!,
                        clientId: widget.complain.clientID!,
                        json: [treatment.toJson()],
                        id: treatment.id!,
                        complainId: widget.complain.id!,
                        complainSub: ComplainSub.treatments,
                        complainStatus: ComplainStatus.all,
                      )..addAll(updateLogJson(

                              log: log,
                              clientId: widget.complain.clientID!,
                              logType: LogType.complain,
                              json: [log.toJson()],
                        petId: widget.complain.petId,
                        complainId: widget.complain.id,

                            )));
                      await SalesMethods(
                        clientStatus: ClientStatus.real,
                              clientId: widget.complain.clientID!,
                              treatment: treatment)
                          .createASale();
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
