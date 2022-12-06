import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:uuid/uuid.dart';

import '../../../constants.dart';
import '../../../constants.dart';
import '../../models/Pet.dart';
import '../../models/Weight.dart';
import '../../models/client_model.dart';
import '../../models/complain/Complain.dart';
import '../../models/complain/FirstInspection.dart';
import '../../models/complain/OrganSystemInspections.dart';
import '../../models/complain/organ_system_inspections_result.dart';
import '../../models/log.dart';
import '../../resources/database_object_paths/complain_paths.dart';
import '../../resources/database_object_paths/log_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/utils.dart';
import '../../widgets/container_with_border.dart';
import '../../widgets/drop_down_list_from_databse_widget_multi_select.dart';
import '../../widgets/text_field_x.dart';
import 'local_widgets/first_inspection_select_widget.dart';

class AddComplainScreen extends StatefulWidget {
  Pet pet;
Complain? complain;
Map<dynamic, dynamic> firstInspectionMap;
  AddComplainScreen({
    Key? key,
    required this.pet,
    this.complain,
    required this.firstInspectionMap

  }) : super(key: key);

  @override
  State<AddComplainScreen> createState() => _AddComplainScreenState();
}

class _AddComplainScreenState extends State<AddComplainScreen> {

  late TextEditingController temperatureController;
  TextEditingController weightController = TextEditingController();
  double temperature = 100;
  List<OrganSystemInspections>? organSystemList = [];
  String complainId = dateTimeDescender(dateTime: DateTime.now()).toString();
  
  late List<bool> chkList; 
List<Uint8List> ?  _images ;
String ? imageDescription;
  @override
  void dispose() {

    super.dispose();

    temperatureController.dispose();
    weightController.dispose();
  }
@override
  void initState() {
  chkList = List.generate(widget.firstInspectionMap.length, (index) => false);
   temperatureController = TextEditingController(
       text: widget.complain!=null ? widget.complain!.firstInspection!.temperature??'' :null);


   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a complain'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFieldX(
            label: 'Weight',
            controller: weightController,
          ),
          TextFieldX(
            label: 'Temperature',
            controller: temperatureController,
          ),
          const Text('Initial Examination'),
ElevatedButton(onPressed: () async {
  await getImageListDialogBox((comment, images) {
    imageDescription = comment;
    _images = images;
  });
}, child: Text('Add Images')),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text('Symptom'), Text('History'), ]),
        Expanded(
        child: SingleChildScrollView(
          child: Column(
                children:[]
                // widget.firstInspectionMap.keys.map((e) {
                //   return FirstInspectionOrganSystemInputWidget(
                //       inspectionMap:widget.firstInspectionMap[e] , title: e,result: (result){
                //        organSystemList!.add(result);
                //
                //   },);
                // }).toList()
              ),

        ),
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    FirstInspection firstInspection = FirstInspection(
                      path:
                          '${widget.pet.path}/complains/$complainId/firstInspection',
                      organSystemInspectionsList: organSystemList,
                      staffMember: FirebaseAuth.instance.currentUser!.email,
                      temperature: temperatureController.text.trim(),
                    );
                    Weight weight = Weight(
                      date: DateTime.now().millisecondsSinceEpoch,
                      weight: weightController.text.trim(),
                    );
                    int dateTime = DateTime.now().millisecondsSinceEpoch;
                    Complain complain = Complain(
                      clientName: widget.pet.clientName,
                      petName: widget.pet.name,
                      nextCallingDate:
                          'current_${DateUtils.dateOnly(DateTime.now()).add(const Duration(days: 1)).millisecondsSinceEpoch}',
                      petId: widget.pet.id,
                      id: complainId,
                      startedDateTime: dateTime,
                      path: '${widget.pet.path}/complains/$complainId',
                      firstInspection: firstInspection,
                      status: ComplainStatus.active.index,
                      weight: weight,
                      clientID: widget.pet.clientId,


                      // client: widget.pet.clientName,
                    );
                    String logId = dateTimeDescender(dateTime: DateTime.now())
                        .toString();
                    Log log = Log(
                      dateTime: DateTime.now().microsecondsSinceEpoch,
                      id: logId,
                      isACall: false,
                      path: '$doctorPath/logs/$logId',
                      addedBy: FirebaseAuth.instance.currentUser!.email,
                      comment: '${widget.pet.name!} > A complain Created',
                      complainId: complain.id,
                      complainPath: complain.path,
                      clientId: complain.clientID,

                    );
                    // FirebaseDatabaseMethods().updateBatch({
                    //   complain.path!: complain.toJson(),
                    //   '$doctorPath/complainFollowUps/${complain.id}':
                    //       complain.toJson(),
                    //   log.path! : log.toJson()
                    // });



                    await FirebaseDatabaseMethods().updateBatch(
                        addComplainJson(
                            petId: widget.pet.id!,
                            clientId: widget.pet.clientId!,
                            json: [complain.toJson()],
                            complainId: complain.id!,
                            complainStatus: ComplainStatus.active));

                    await FirebaseDatabaseMethods().updateBatch(updateLogJson(
                      clientId: complain.clientID!,
                      logType: LogType.complain,
                      petId: complain.petId,
                      json: [log.toJson()],
                      complainId: complain.id!,
                      log: log
                    ));
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
    );
  }

  FirstInspectionSelectWidgetMultiSelect organSystemExaminationWidget(
      {required String system,
        required Function(List<OrganSystemInspectionsResult?>?) onConfirm,
      //  required List<OrganSystemInspectionsResult?>? selectedValues,
      }) {
    return FirstInspectionSelectWidgetMultiSelect(
        databasePath: '$examinationCategoriesPath/$system',

        databaseVariable: 'name',
        hintText: system,

        onConfirm: (value) {
         // onConfirm(value);
        }, );
  }
}
