
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controllers/global_live_variables_controller.dart';
import '../models/client_model.dart';
import '../models/log.dart';
import '../resources/database_object_paths/log_paths.dart';
import '../resources/firebase_database_methods.dart';
import '../screens/authentication_screens/local_widgets/button_x.dart';
import '../screens/authentication_screens/local_widgets/text_field_x.dart';
import 'utils.dart';

class AddLogScreen extends StatefulWidget {
  String? complainId;

  String? vaccinationId;
  String? treatmentId;

  String? addedBy;
  String? petId;
  String? clientId;
  String? salesId;
  ClientModel? client;
  bool isACall;

  LogType logType;

  AddLogScreen({
    Key? key,
    this.complainId,
    this.vaccinationId,
    this.treatmentId,
    this.clientId,
    this.salesId,
    this.client,
    this.petId,
    this.isACall = false,
    required this.logType,
  }) : super(key: key);

  @override
  State<AddLogScreen> createState() => _AddLogScreenState();
}

class _AddLogScreenState extends State<AddLogScreen> {
  TextEditingController logController = TextEditingController();
bool toDoctorSelected = false;
  @override
  void dispose() {
    logController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Add a Log'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(

                child: TextFieldX(
                  label: 'Add a Log',
                  controller: logController, icon: Icons.logo_dev,
                ),
              ),
              Checkbox(value: toDoctorSelected, onChanged: (value){
                setState((){
                  toDoctorSelected = value!;
                });

              })
            ],
          ),
         Align(
           
         ),
          ButtonX(
            text: 'Save',
            onTap: () {
              String logId =
                  dateTimeDescender(dateTime: DateTime.now()).toString();
              Log log = Log(
                id: logId,
                addedBy: FirebaseAuth.instance.currentUser!.email!,

                dateTime: DateTime.now().microsecondsSinceEpoch,
                vaccinationId: widget.vaccinationId,
                complainId: widget.complainId,
                client: widget.client,
                clientId: widget.clientId,
                comment: logController.text.trim(),
                isACall: widget.isACall,
                salesId: widget.salesId,
                treatmentId: widget.treatmentId,
                addedByName: FirebaseAuth.instance.currentUser!.displayName,
                addedById: FirebaseAuth.instance.currentUser!.uid,
                toDoctorId: toDoctorSelected ? Get.find<GlobalLiveVariablesController>().currentDoctor.value : null,
              );
              FirebaseDatabaseMethods().updateBatch(updateLogJson(
                  log: log,
                  clientId: widget.clientId!,
                  complainId: widget.complainId,
                  vaccinationId:  widget.vaccinationId,
                  petId: widget.petId,
                  logType: widget.logType,
                  json: [log.toJson()]));
              Get.back();
            },
          ),
          ButtonX(
            text: 'Cancel',
            onTap: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
