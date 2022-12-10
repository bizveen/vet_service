
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:vet_service/controllers/client_controller.dart';
import 'package:vet_service/screens/add_treatment_screen/add_treatment_screen_controller.dart';
import 'package:vet_service/screens/complain_screens/doctor_work_bench.dart';
import '../../models/client_model.dart';
import '../../models/complain/Complain.dart';
import '../../resources/database_object_paths/complain_paths.dart';
import '../../resources/database_object_paths/log_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../timeline_screen/timeline_screen.dart';
import '../../utils/add_log_screen.dart';
import '../../utils/tiny_space.dart';
import '../../utils/utils.dart';
import '../../widgets/add_images_to_timeline_button.dart';
import '../../widgets/call_icon_widget.dart';
import '../../widgets/date_picker_widget.dart';
import '../../widgets/log_tile.dart';
import '../../widgets/logs_widget.dart';
import '../add_treatment_screen/add_treatment_screen.dart';
import '../calling_screen/calling_screen.dart';
import 'add_complain_screen.dart';

import 'local_widgets/differential_diagnosis_details_widget.dart';
import 'local_widgets/first_inspection_details_widget.dart';
import 'local_widgets/treatments_details_widget.dart';

class ComplainDetailsScreen extends GetWidget<ClientController> {
  String  complainId;
  String petId;
  String clientId;
  ComplainStatus complainStatus;

  ComplainDetailsScreen({
    Key? key,
    required this.complainId,
    required this.petId,
    required this.clientId,
    required this.complainStatus,
  }) : super(key: key);

  TextEditingController dDCommentController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<ClientModel>(
      stream: controller.getClientFromId(clientId ),
      builder: (context, snapshot,) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        ClientModel client = snapshot.data!;
            Complain complain = client.pets!.where((element) => element!.id == petId)
                .first!.complains!.where((element) => element!.id == complainId).first!;

            return Scaffold(
              appBar: AppBar(
                title: const Text('Complain Details Screen'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(CallingScreen(
                          contactList: client.contacts!,
                          logType: LogType.complain,
                          clientId: client.id!,
                          petId: complain.petId,
                          complainId: complain.id!,
                          logList: complain.logList,
                        ));
                      },
                      icon: Icon(Icons.call))
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ClientCardWidget(
                      //     clientModel: widget.client,
                      //     selectedPetId: widget.complain.petId),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Presented On : '),
                            Text(
                                complain.startedDateTime != null
                                    ? dateIntToFormattedDateWithTime(
                                        fromMicroSecondsSinceEpoch:
                                            complain.startedDateTime!)
                                    : 'No presented details',
                                style: Get.textTheme.headline6),
                          ],
                        ),
                      ),
                      complain.getFirstInspectionSummery(),
                      ElevatedButton(
                          onPressed: () {
                            Get.to(DoctorWorkBenchScreen(
                              complain: complain,
                            ));
                          },
                          child: Text("Doctor's Work Bench")),
                      Row(
                        children: [
                          Text(
                            'Treatments',
                            style: Get.textTheme.headline6,
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(AddTreatmentScreen(complain: complain));
                            },
                            icon: Icon(Icons.add),
                          )
                        ],
                      ),
                      complain.getTreatmentSummery(),
                      DatePickerWidget(
                        pickedDate: (dateTime) async {
                          await FirebaseDatabaseMethods().updateBatch(
                              updateComplainJson(
                                  petId: complain.petId!,
                                  clientId: complain.clientID!,
                                  json: [dateTime.microsecondsSinceEpoch],
                                  complainId: complain.id!,
                                  variables: ['nextCallingDate'],
                                  complainStatus: complainStatus));
                        },
                        buttonText: 'Next Calling Date : ',
                      ),
                      Row(
                        children: [
                          AddTimeLineImagesButtonWidget(clientId: complain.clientID!, petId: complain.petId!),
                          TinySpace(),
                          ElevatedButton(onPressed: (){
                            Get.to(TimelineScreen(clientId: client.id!, petId: complain.petId!));
                          }, child: Text('Show Time Line'))
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.to(AddLogScreen(
                              petId: complain.petId,
                              logType: LogType.complain,
                              complainId: complain.id,
                              isACall: false,
                              client:client,
                              clientId: complain.clientID,
                            ));
                          },
                          child: Text('Add a Log')),//Add Log Button
                      (complain.logList != null && complain.logList!.isNotEmpty)
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: complain.logList!.length,
                              itemBuilder: (context, index) {
                                if (complain.logList!.length > 1) {
                                  complain.logList!.sort(
                                    (a, b) => a!.id.toInt()! - b!.id!.toInt()!,
                                  );
                                }
                                return LogTileWidget(
                                    log: complain.logList![index]!);
                              },
                            )
                          : const Text('No Logs available'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Visibility(
                            visible: complain.status != 0,
                            child: ElevatedButton(
                                onPressed: () async {
                                  await FirebaseDatabaseMethods().updateBatch(
                                      swapComplain(
                                          petId: complain.petId!,
                                          clientId: complain.clientID!,
                                          complainId: complain.id!,
                                          json: complain.toJson(),
                                          from: ComplainStatus
                                              .values[complain.status!],
                                          to: ComplainStatus.active));
                                },
                                child: const Text('Active')),
                          ),
                          Visibility(
                            visible: complain.status != 1,
                            child: ElevatedButton(
                                onPressed: () async {
                                  await FirebaseDatabaseMethods()
                                      .updateBatch(swapComplain(
                                    petId: complain.petId!,
                                    complainId: complain.id!,
                                    clientId: complain.clientID!,
                                    from: ComplainStatus.values[complain.status!],
                                    to: ComplainStatus.completed,
                                    json: complain.toJson(),
                                  ));
                                },
                                child: const Text('Completed')),
                          ),
                          Visibility(
                            visible: complain.status != 2,
                            child: ElevatedButton(
                              onPressed: () async {
                                await FirebaseDatabaseMethods().updateBatch(
                                  swapComplain(
                                      petId: complain.petId!,
                                      clientId: complain.clientID!,
                                      complainId: complain.id!,
                                      json: complain.toJson(),
                                      from: ComplainStatus.values[complain.status!],
                                      to: ComplainStatus.dismissed),
                                );
                              },
                              child: const Text('dismissed'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }

  }

